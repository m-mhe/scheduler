import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  const Note({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:10),
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
