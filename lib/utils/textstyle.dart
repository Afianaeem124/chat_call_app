import 'dart:ui';

import 'package:chat_call_app/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static final ContactText = GoogleFonts.poppins(
      fontWeight: FontWeight.w400, fontSize: 18, color: AppColor.blackk);
  static final ContactHeADING = GoogleFonts.poppins(
      fontWeight: FontWeight.w700, fontSize: 25, color: AppColor.GreyContact);
  static final dialoghead = GoogleFonts.poppins(
      fontWeight: FontWeight.w500, fontSize: 20, color: AppColor.dialogHeading);
  static final Contactsubs = GoogleFonts.poppins(
      fontWeight: FontWeight.w500, fontSize: 15, color: AppColor.GreyContact);
  static final dialogblue = GoogleFonts.poppins(
      fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xff0062EC));

  static final DialpadNumber = GoogleFonts.poppins(
      fontWeight: FontWeight.w400, fontSize: 40, color: Color(0xff2F2E41));
  static final DialedNumber = GoogleFonts.poppins(
      fontWeight: FontWeight.w400, fontSize: 35, color: Color(0xff2F2E41));
}
