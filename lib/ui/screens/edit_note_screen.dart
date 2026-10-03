import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:scheduler/data/note_data_model.dart';
import 'package:scheduler/local_database.dart';
import 'package:scheduler/ui/widgets/bottom_popup_message.dart';
import 'package:scheduler/ui/widgets/common_bottom_nav_bar.dart';
import '../utils/theme_colors.dart';
import '../widgets/common_app_bar.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({
    super.key,
    required this.index,
    required this.title,
    required this.description,
  });

  final int index;
  final String title;
  final String description;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final TextEditingController _tECTitle = TextEditingController();

  final TextEditingController _tECDescription = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tECTitle.text = widget.title;
    _tECDescription.text = widget.description;
  }

  Future<void> onPressed() async {
    if (_tECTitle.text.trim() == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        bottomPopupMessage(
          text: "Please enter a title to update the note!",
          color: Colors.red,
        ),
      );
    } else {
      await LocalDatabase.editUserNote(
        NoteDataModel(
          ID: widget.index,
          title: _tECTitle.text,
          body: _tECDescription.text,
          updation_time: DateTime.now().toString(),
        ),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(bottomPopupMessage(text: "Updated!", color: Colors.green));
      Get.offAll(() => CommonBottomNavBar());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.sizeOf(context).height / 30,
              ),
              child: TextField(
                controller: _tECTitle,
                textInputAction: TextInputAction.next,
                maxLength: 20,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Get.isDarkMode
                      ? ThemeColors.darkAccent
                      : ThemeColors.titleColor,
                ),
                decoration: const InputDecoration(hintText: 'Title:'),
              ),
            ),
            TextField(
              controller: _tECDescription,
              maxLines: 10,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Get.isDarkMode
                    ? ThemeColors.darkAccent
                    : ThemeColors.titleColor,
              ),
              decoration: const InputDecoration(
                hintText: 'Description (optional):',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(
                    double.maxFinite,
                  ), //Size(double width, double height)
                ),
                child: Text("Update the Note"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tECDescription.dispose();
    _tECTitle.dispose();
    super.dispose();
  }
}
