import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final String _fontPoppins = GoogleFonts.poppins().fontFamily!;

  static TextStyle font20_700TextStyle = TextStyle(
    fontSize: 20,
    fontFamily: _fontPoppins,
    fontWeight: FontWeight.w700,
  );
  static TextStyle font24TextStyle = TextStyle(
    fontSize: 24,
    fontFamily: _fontPoppins,
    fontWeight: FontWeight.w600,
  );
  static TextStyle font14_600TextStyle = TextStyle(
    fontSize: 14,
    fontFamily: _fontPoppins,
    fontWeight: FontWeight.w600,
  );
  static TextStyle font14_500TextStyle = TextStyle(
    fontSize: 14,
    fontFamily: _fontPoppins,
    fontWeight: FontWeight.w500,
  );
  static TextStyle font16_500TextStyle = TextStyle(
    fontSize: 16,
    fontFamily: _fontPoppins,
    fontWeight: FontWeight.w500,
  );
  static TextStyle font18_600TextStyle = TextStyle(
    fontSize: 18,
    fontFamily: _fontPoppins,
    fontWeight: FontWeight.w600,
  );

}
