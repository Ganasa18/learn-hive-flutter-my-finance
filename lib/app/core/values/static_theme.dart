import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color whiteColor = const Color(0xffFFFFFF);
Color greyColor = const Color(0xffA4A8AE);
Color lightGreyColor = const Color(0xffF8F9FA);
Color blackColor = const Color(0xff14193F);
Color lightBlackColor = const Color(0xff343434);
Color teaGreenColor = const Color(0xffCCE4C4);
Color pinkColor = const Color(0xffEAD9D5);

// Fonts

TextStyle baseTextStyle = GoogleFonts.arvo();

TextStyle blackTextStyle = GoogleFonts.arvo(
  color: blackColor,
);
TextStyle lightBlackTextStyle = GoogleFonts.arvo(
  color: lightBlackColor,
);
TextStyle whiteTextStyle = GoogleFonts.arvo(
  color: whiteColor,
);
TextStyle greyTextStyle = GoogleFonts.arvo(
  color: greyColor,
);

TextStyle redTextStyle = GoogleFonts.arvo(
  color: pinkColor,
);
TextStyle greenTextStyle = GoogleFonts.arvo(
  color: teaGreenColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;
