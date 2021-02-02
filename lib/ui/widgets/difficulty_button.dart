import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DifficultyButton extends StatelessWidget {
  final AutoSizeGroup textGroup;
  final Color backgroundColor;
  final Color borderColor;
  final String label;
  final VoidCallback onPressed;

  DifficultyButton(
      {this.textGroup,
      this.backgroundColor,
      this.borderColor,
      this.label,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13.h),
              side:
              BorderSide(width: 4, color: borderColor)),
          minimumSize: Size(0, 60.h),
        ),
        child: AutoSizeText(
          label,
          maxLines: 1,
          group: textGroup,
          style: GoogleFonts.poppins(
              color: borderColor,
              fontWeight: FontWeight.w600,
              fontSize: 20.sp),
        ));
  }
}
