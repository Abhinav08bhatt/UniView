import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

// Colors : 
const Color graphicWhite = Color(0xffF5F8FF);
const Color graphicBlack = Color(0xff475569);
const Color primaryColor =  Color(0xFF40A9FF);
const Color secondaryColor = Color(0xFFDFEEFF);
const Color thirdColor = Color(0xFF0084FF);

// Spacing
const double kSpace4 = 4;
const double kSpace6 = 6;
const double kSpace8 = 8;
const double kSpace12 = 12;
const double kSpace16 = 16;
const double kSpace20 = 20;
const double kSpace24 = 24;

// TextStyles
final TextStyle kGraphicLogo = GoogleFonts.robotoSerif(
  fontWeight: FontWeight.w600,
  // color: Colors.black,
  color: graphicBlack,
  fontSize: 24,
  height: 1,
  letterSpacing: 0.50
);
final TextStyle kHeadingStyle = GoogleFonts.inter(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);
final TextStyle kSubHeadingStyle = GoogleFonts.inter(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: graphicBlack,
);
final TextStyle kInfoHeadingStyle = GoogleFonts.inter(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: Colors.black,
  letterSpacing: 0
);
final TextStyle kInfoStyle = GoogleFonts.inter(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: thirdColor,
);
final TextStyle kTagsStyle = GoogleFonts.inter(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: graphicBlack,
);

// sized box
const SizedBox kH4 = SizedBox(height: kSpace4);
const SizedBox kH6 = SizedBox(height: kSpace6);
const SizedBox kH8 = SizedBox(height: kSpace8);
const SizedBox kH16 = SizedBox(height: kSpace16);
const SizedBox kH20 = SizedBox(height: kSpace20);

const SizedBox kW4 = SizedBox(width: kSpace4);
const SizedBox kW6 = SizedBox(width: kSpace6);
const SizedBox kW8 = SizedBox(width: kSpace8);
const SizedBox kW16 = SizedBox(width: kSpace16);

// extra
Future<void> openExternalLink(String url) async {
  await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  );
}

void pushPage(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => page),
  );
}
