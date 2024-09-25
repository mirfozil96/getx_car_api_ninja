import 'package:flutter/material.dart';


abstract class AppTypography {


  static const TextStyle basicFont = TextStyle(fontWeight: FontWeight.w600, fontSize: 32);

  //#title
  static const TextStyle accentTitle = TextStyle(fontWeight: FontWeight.w700, fontSize: 36);
  static const TextStyle accentTitle1 = TextStyle(fontWeight: FontWeight.w600, fontSize: 28);
  static const TextStyle accentTitle2 = TextStyle(fontWeight: FontWeight.w600, fontSize: 23);
  static const TextStyle accentTitle3 = TextStyle(fontWeight: FontWeight.w600, fontSize: 21);
  static const TextStyle title1 = TextStyle(fontWeight: FontWeight.w600, fontSize: 24);
  static const TextStyle title2 = TextStyle(fontWeight: FontWeight.w500, fontSize: 20);
  static const TextStyle title3 = TextStyle(fontWeight: FontWeight.w600, fontSize: 18);

  //#headline
  static const TextStyle headline1 = TextStyle(fontWeight: FontWeight.w500, fontSize: 18);
  static const TextStyle headline2 = TextStyle(fontWeight: FontWeight.w500, fontSize: 16);
  static const TextStyle headline3 = TextStyle(fontWeight: FontWeight.w500, fontSize: 15);
  static const TextStyle headline4 = TextStyle(fontWeight: FontWeight.w500, fontSize: 14);

  //#subhead
  static const TextStyle subheadMedium = TextStyle(fontWeight: FontWeight.w500, fontSize: 14);
  static const TextStyle subheadRegular = TextStyle(fontWeight: FontWeight.w400, fontSize: 14);



  //#body
  static const TextStyle bodyText = TextStyle(fontWeight: FontWeight.w400, fontSize: 16);
  static const TextStyle bodyParagraph1  = TextStyle(fontWeight: FontWeight.w400, fontSize: 15);
  static const TextStyle bodyParagraph2  = TextStyle(fontWeight: FontWeight.w400, fontSize: 14);



  //#caption
  static const TextStyle caption1 = TextStyle(fontWeight: FontWeight.w600, fontSize: 12);
  static const TextStyle caption2 = TextStyle(fontWeight: FontWeight.w500, fontSize: 12);
  static const TextStyle caption3 = TextStyle(fontWeight: FontWeight.w400, fontSize: 12);
  static const TextStyle caption4 = TextStyle(fontWeight: FontWeight.w400, fontSize: 10);



  //#active
  static const TextStyle active1 = TextStyle(fontWeight: FontWeight.w500, fontSize: 16);
  static const TextStyle active2 = TextStyle(fontWeight: FontWeight.w500, fontSize: 15);
  static const TextStyle active3 = TextStyle(fontWeight: FontWeight.w500, fontSize: 14);


  //#others //Footnote

  static const TextStyle footnote1 = TextStyle(fontWeight: FontWeight.w600, fontSize: 13);
  static const TextStyle footnote2 = TextStyle(fontWeight: FontWeight.w500, fontSize: 13);
  static const TextStyle footnote3 = TextStyle(fontWeight: FontWeight.w400, fontSize: 13);


  //#old style

  static const TextStyle bodyLargeBold = TextStyle(fontWeight: FontWeight.w700, fontSize: 16);
  static const TextStyle bodyMediumRegular = TextStyle(fontWeight:FontWeight.w400, fontSize: 14);
  static const TextStyle bodyMediumSemiBold = TextStyle(fontWeight: FontWeight.w600, fontSize: 14);

}
