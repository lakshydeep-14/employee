import 'package:employee/controller/db.dart';
import 'package:employee/features/employee_list/employee_list.dart';
import 'package:employee/main.dart';
import 'package:employee/utils/app_extension.dart';

AppBar customAppBar(String title, {bool delIcon = false, Employee? employee}) {
  return AppBar(
    backgroundColor: AppColors.primary,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: Text(
      title,
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
          fontFamily: GoogleFonts.roboto().fontFamily),
    ),
    actions: [
      if (delIcon == true)
        GestureDetector(
            onTap: () async {
              await databaseManager.deleteemployee(employee!.id!);
              Get.offAll(EmployeeListScreen());
            },
            child: Icon(Icons.delete)),
      SizedBox(
        width: 10,
      )
    ],
  );
}
