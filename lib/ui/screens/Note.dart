import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/ui/screens/create_note_screen.dart';
import '../widgets/note_tile.dart';

class Note extends StatefulWidget {
  const Note({super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int i) {
            return NoteTile(
              index: i,
            );
          },
          separatorBuilder: (BuildContext context, int i) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: 500,
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'createNoteFab',
            onPressed: () {
              Get.to(()=>CreateNoteScreen());
            },
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: FloatingActionButton(
              onPressed: () {},
              child: const Icon(
                Icons.search_outlined,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
