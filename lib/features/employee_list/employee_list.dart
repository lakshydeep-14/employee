import 'package:employee/features/employee_list/components/employee_tile.dart';
import 'package:employee/main.dart';

import '../../controller/db.dart';
import '../add_or_edit_employee/add_employee.dart';
import 'package:employee/utils/app_extension.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() =>
      _EmployeeListScreenState();
}

class _EmployeeListScreenState
    extends State<EmployeeListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<Employee>>
      fetchEmployeesFromDatabase() async {
    Future<List<Employee>> employees =
        databaseManager.readEmployee();
    return employees;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Employee>>(
        future: databaseManager.readEmployee(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.hasData == null ||
                snapshot.data!.isEmpty) {
              return Center(
                child: SvgPicture.asset(
                    'assets/no_employee.svg'),
              );
            }
            return ListView(
              children: [
                if (snapshot.data!
                    .where((element) =>
                        element.toDate != "noDate" &&
                        element.toDate != "")
                    .isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16),
                    child: Text(
                      "Current employees",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                          fontSize: 16),
                    ),
                  ),
                if (snapshot.data!
                    .where((element) =>
                        element.toDate != "noDate" &&
                        element.toDate != "")
                    .isNotEmpty)
                  ListView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!
                          .where((element) =>
                              element.toDate != "noDate" &&
                              element.toDate != "")
                          .toList()
                          .length,
                      itemBuilder: (context, i) {
                        var data = snapshot.data!
                            .where((element) =>
                                element.toDate !=
                                    "noDate" &&
                                element.toDate != "")
                            .toList()[i];
                        return EmployeeTile(employee: data);
                      }),
                if (snapshot.data!
                    .where((element) =>
                        element.toDate == "noDate" ||
                        element.toDate == "")
                    .isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16),
                    child: Text(
                      "Previous employees",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                          fontSize: 16),
                    ),
                  ),
                if (snapshot.data!
                    .where((element) =>
                        element.toDate == "noDate" ||
                        element.toDate == "")
                    .isNotEmpty)
                  ListView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!
                          .where((element) =>
                              element.toDate == "noDate" ||
                              element.toDate == "")
                          .toList()
                          .length,
                      itemBuilder: (context, i) {
                        var data = snapshot.data!
                            .where((element) =>
                                element.toDate ==
                                    "noDate" ||
                                element.toDate == "")
                            .toList()[i];
                        return EmployeeTile(employee: data);
                      }),
              ],
            );
          } else {
            return Container(
              alignment: AlignmentDirectional.center,
              child: const CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
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
