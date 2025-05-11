import 'package:flutter/material.dart';
import 'package:hot_note/core/common/loader.dart';
import 'package:hot_note/core/theme/app_colors.dart';

class CstmBtn extends StatelessWidget {
  final VoidCallback onTap;
  final String txt;
  final bool isLoading;
  const CstmBtn({
    super.key,
    required this.txt,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(14),

        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              blurRadius: 0.5,
              spreadRadius: 0.1,
              color: AppColors.textPrimary,
              blurStyle: BlurStyle.normal,
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child:
            isLoading
                ? Loader()
                : Text(
                  txt,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
      ),
    );
  }
}
