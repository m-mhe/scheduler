import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/data/note_data_model.dart';
import 'package:scheduler/local_database.dart';
import 'package:scheduler/ui/screens/create_note_screen.dart';
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
              onPressed: () {},
              child: const Icon(Icons.search_outlined, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
