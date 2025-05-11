import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hot_note/core/theme/app_colors.dart';
import 'package:hot_note/data/models/task.dart';

class ShowTaskCard extends StatelessWidget {
  final VoidCallback onTap;
  final Task task;
  const ShowTaskCard({super.key, required this.onTap, required this.task});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 300, // Adjust width based on your layout needs
                  child: Text(
                    task.title,
                    style: TextStyle(fontSize: 16, overflow: TextOverflow.fade),
                    maxLines: 1, // Ensure text is confined to one line
                    softWrap: false, // Prevent text from wrapping
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    task.desc,
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
              ],
            ),
            Text(
              task.isUploaded ? "Uploaded" : "Queued",
              style: TextStyle(
                color: task.isUploaded ? AppColors.uploaded : AppColors.queued,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
