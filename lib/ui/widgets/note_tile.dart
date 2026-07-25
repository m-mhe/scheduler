import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/theme_colors.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    super.key,
    required this.index,
  });

  final int index;

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
          borderRadius: BorderRadius.circular(7)),
      child: ListTile(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  title: Text(
                    "NOTE TITLE",
                    textAlign: TextAlign.center,
                  ),
                  content: Text(
                    "What would you like to do with this note?",
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {},
                        child: Icon(Icons.delete)),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {},
                        child: Icon(Icons.edit)),
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Close"))
                  ],
                );
              });
        },
        title: Text(
          "Note Title".toUpperCase(),
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Get.isDarkMode
                    ? ThemeColors.darkMain
                    : ThemeColors.titleColor,
              ),
        ),
        subtitle: Text(
          textAlign: TextAlign.justify,
          """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London, took a 1914 Cicero translation and scrambled it to make dummy text for Letraset's Body Type sheets. It has survived not only many decades, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised thanks to these sheets and more recently with desktop publishing software like Aldus PageMaker and Microsoft Word including versions of Lorem Ipsum.""",
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Get.isDarkMode
                  ? ThemeColors.darkMain
                  : ThemeColors.titleColor),
        ),
      ),
    );
  }
}
