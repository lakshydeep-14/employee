import 'package:employee/utils/app_extension.dart';

AppBar customAppBar(String title) {
  return AppBar(
    backgroundColor: AppColors.primary,
    elevation: 0,
    title: Text(
      title,
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
          fontFamily: GoogleFonts.roboto().fontFamily),
    ),
  );
}
