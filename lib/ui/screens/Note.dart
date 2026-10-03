import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/data/note_data_model.dart';
import 'package:scheduler/local_database.dart';
import 'package:scheduler/ui/screens/create_note_screen.dart';
import 'package:scheduler/ui/screens/searched_notes.dart';
import 'package:scheduler/ui/widgets/bottom_popup_message.dart';
import '../utils/theme_colors.dart';
import '../widgets/note_tile.dart';

class Note extends StatefulWidget {
  const Note({super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  Future<void> _loadNotes() async {
    _userNotes = await LocalDatabase.fetchUserNote();
    setState(() {});
  }

  @override
  void initState() {
    _loadNotes();
    super.initState();
  }

  List<NoteDataModel> _userNotes = [];
  final TextEditingController _tECSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Visibility(
          visible: _userNotes.isNotEmpty,
          replacement: Center(
            child: Text(
              'Empty',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Get.isDarkMode
                    ? ThemeColors.darkAccent
                    : ThemeColors.accentColor,
              ),
            ),
          ),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int i) {
              return NoteTile(
                index: _userNotes[i].ID ?? i,
                title: _userNotes[i].title,
                description: _userNotes[i].body,
                onNoteDelete: () async {
                  await LocalDatabase.deleteFromUserNote(
                    ID: _userNotes[i].ID ?? i,
                  );
                  await _loadNotes();
                  ScaffoldMessenger.of(context).showSnackBar(
                    bottomPopupMessage(
                      text: 'Note is successfully deleted!',
                      color: Colors.green,
                    ),
                  );
                  Get.back();
                },
              );
            },
            separatorBuilder: (BuildContext context, int i) {
              return SizedBox(height: 10);
            },
            itemCount: _userNotes.length,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'createNoteFab',
            onPressed: () {
              Get.to(() => CreateNoteScreen());
            },
            child: const Icon(Icons.add, size: 30),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: FloatingActionButton(
              heroTag: 'searchNoteFab',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      actionsAlignment: MainAxisAlignment.spaceBetween,
                      title: Text("Search Notes", textAlign: TextAlign.center),
                      content: TextField(
                        controller: _tECSearch,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Get.isDarkMode
                              ? ThemeColors.darkAccent
                              : ThemeColors.titleColor,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Search notes by title:',
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("Close"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            if (_tECSearch.text.trim() == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                bottomPopupMessage(
                                  text: "Please enter a keyword to search.",
                                  color: Colors.red,
                                ),
                              );
                            } else {
                              Get.off(
                                  () => SearchedNotes(searchKeyWord: _tECSearch.text),
                              );
                            }
                          },
                          child: Icon(Icons.search_outlined, size: 20),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Icon(Icons.search_outlined, size: 30),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tECSearch.dispose();
    super.dispose();
  }
}
