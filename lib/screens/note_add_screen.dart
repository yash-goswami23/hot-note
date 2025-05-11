import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_note/bloc/home/home_bloc.dart';
import 'package:hot_note/core/routes/app_routes.dart';
import 'package:hot_note/core/theme/app_colors.dart';
import 'package:hot_note/core/utils/show_toast.dart';
import 'package:hot_note/data/models/note.dart';

class NoteAddScreen extends StatefulWidget {
  const NoteAddScreen({super.key});

  @override
  State<NoteAddScreen> createState() => _NoteAddScreenState();
}

class _NoteAddScreenState extends State<NoteAddScreen> {
  final titleController = TextEditingController();

  final descController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note", style: TextStyle(fontWeight: FontWeight.w500)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 15),
            TextField(
              controller: titleController,
              style: TextStyle(fontSize: 16),
              cursorColor: AppColors.textSecondary,
              decoration: InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.textSecondary.withOpacity(0.8),
                    width: 1.5,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.textSecondary.withOpacity(0.8),
                    width: 1.5,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: descController,
                maxLines: 300,
                style: TextStyle(fontSize: 16),
                cursorColor: AppColors.textSecondary,
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(fontSize: 16),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final String title = titleController.text.trim();
          final String desc = descController.text.trim();
          print("$title, $desc");
          if (title.isNotEmpty && desc.isNotEmpty) {
            final note = Note(title: title, desc: desc);
            context.read<HomeBloc>().add(AddNoteEvent(note));
            context.go(AppRoutes.home);
          } else {
            showToast(context: context, msg: "Enter Title and Description");
          }
        },
        elevation: 2,
        child: Icon(Icons.check, color: AppColors.textPrimary),
      ),
    );
  }
}
