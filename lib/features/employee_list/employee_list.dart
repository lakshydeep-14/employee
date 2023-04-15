import 'package:employee/features/employee_list/components/employee_tile.dart';

import '../add_or_edit_employee/add_employee.dart';
import 'package:employee/utils/app_extension.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Text(
              "Current employees",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                  fontSize: 16),
            ),
          ),
          EmployeeTile(name: "Lakshydeep", role: "Flutter", date: "678-780678"),
          EmployeeTile(name: "Lakshydeep", role: "Flutter", date: "678-780678"),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Text(
              "Previous employees",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                  fontSize: 16),
            ),
          ),
          EmployeeTile(name: "Lakshydeep", role: "Flutter", date: "678-780678"),
          EmployeeTile(name: "Lakshydeep", role: "Flutter", date: "678-780678"),
        ],
      ),
      // Center(
      //   child: SvgPicture.asset('assets/no_employee.svg'),
      // ),
      floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: const Icon(
            Icons.add,
            color: AppColors.white,
          ),
          onPressed: () {
            Get.to(() => const AddEmployeeScreen());
          }),
      appBar: customAppBar('Employee List'),
    );
  }
}
