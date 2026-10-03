import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduler/ui/screens/edit_note_screen.dart';
import '../utils/theme_colors.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    super.key,
    required this.index,
    required this.title,
    required this.description,
    required this.onNoteDelete,
  });

  final int index;
  final String title;
  final String description;
  final VoidCallback onNoteDelete;

  @override
  Widget build(BuildContext context) {
    final List<Color> colorPlate = [
      Color(0XFFC0C78C), //Base Color
      Color(0xfffcdfd5),
      Color(0xffafc78c),
      Color(0xfffcf9d5),
      Color(0xfffcd5d5),
      Color(0xff8cc7ab),
      Color(0XFFFCEBD5), //Base Color
      Color(0xffc7b98c),
      Color(0xff8cbdc7),
      Color(0xff8ec78c),
    ];
    return Container(
      decoration: BoxDecoration(
        color: colorPlate[index % 10],
        borderRadius: BorderRadius.circular(7),
      ),
      child: ListTile(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                actionsAlignment: MainAxisAlignment.spaceBetween,
                title: Text(title.toUpperCase(), textAlign: TextAlign.center),
                content: Text(
                  "What would you like to do with this note?",
                  textAlign: TextAlign.center,
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: onNoteDelete,
                    child: Icon(Icons.delete),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      Get.off(
                        () => EditNoteScreen(
                          index: index,
                          title: title,
                          description: description,
                        ),
                      );
                    },
                    child: Icon(Icons.edit),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Close"),
                  ),
                ],
              );
            },
          );
        },
        title: Text(
          title.toUpperCase(),
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Get.isDarkMode
                ? ThemeColors.darkMain
                : ThemeColors.titleColor,
          ),
        ),
        subtitle: Text(
          textAlign: TextAlign.justify,
          description,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: Get.isDarkMode
                ? ThemeColors.darkMain
                : ThemeColors.titleColor,
          ),
        ),
      ),
    );
  }
}
