import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/data/note_data_model.dart';
import 'package:scheduler/local_database.dart';
import 'package:scheduler/ui/widgets/common_app_bar.dart';
import '../utils/theme_colors.dart';
import '../widgets/note_tile.dart';

class SearchedNotes extends StatefulWidget {
  const SearchedNotes({super.key, required this.searchKeyWord});

  final String searchKeyWord;

  @override
  State<SearchedNotes> createState() => _SearchedNotesState();
}

class _SearchedNotesState extends State<SearchedNotes> {
  Future<void> _loadNotes() async {
    _userNotes = await LocalDatabase.searchThroughUserNote(
      widget.searchKeyWord,
    );
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
      appBar: commonAppBar(context),
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
    );
  }
}
