import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_note/core/routes/app_routes.dart';
import 'package:hot_note/core/theme/app_colors.dart';

class NoteAddScreen extends StatelessWidget {
  const NoteAddScreen({super.key});

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
        onPressed: () => context.go(AppRoutes.dashboard),
        elevation: 2,
        child: Icon(Icons.check, color: AppColors.textPrimary),
      ),
    );
  }
}
