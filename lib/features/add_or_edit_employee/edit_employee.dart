import 'package:employee/features/add_or_edit_employee/components/calender.dart';
import 'package:employee/features/add_or_edit_employee/components/calender_popup2.dart';
import 'package:employee/features/add_or_edit_employee/components/text_field.dart';
import 'package:employee/features/employee_list/employee_list.dart';
import 'package:employee/utils/app_extension.dart';
import 'package:intl/intl.dart';

import '../../controller/db.dart';
import '../../main.dart';
import 'components/role.dart';

class EditEmployeeScreen extends StatefulWidget {
  final Employee employee;
  const EditEmployeeScreen({super.key, required this.employee});

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  TextEditingController nameController = TextEditingController();
  String? hint, role, toDate, fromDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hint = widget.employee.name;
    role = widget.employee.role;
    toDate = widget.employee.toDate;
    fromDate = widget.employee.fromDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Edit Employee Details',
          delIcon: true, employee: widget.employee),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 24),
        child: Column(children: [
          CustomTextField(
              icon: AppImagePath.name, hint: hint!, controller: nameController),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.0),
                  ),
                ),
                context: context,
                builder: (BuildContext context) => const RoleScreen(),
              );
            },
            child: CustomTextField(
                icon: AppImagePath.role,
                enabled: false,
                hint: role!,
                controller: TextEditingController()),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              contentPadding: EdgeInsets.zero,
                              titlePadding: EdgeInsets.zero,
                              buttonPadding: EdgeInsets.zero,
                              actionsPadding: EdgeInsets.zero,
                              insetPadding: EdgeInsets.zero,
                              content: Builder(builder: (context) {
                                return Container(
                                    height: 600,
                                    width: 500,
                                    margin: EdgeInsets.all(8),
                                    child: CalenderPopUp());
                              }),
                            );
                          });
                    },
                    child: CustomTextField(
                        enabled: false,
                        icon: AppImagePath.date,
                        hint: dateFormattor(DateTime.parse(fromDate!)),
                        controller: TextEditingController())),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: SvgPicture.asset(AppImagePath.rightArrow),
              ),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          contentPadding: EdgeInsets.zero,
                          titlePadding: EdgeInsets.zero,
                          buttonPadding: EdgeInsets.zero,
                          actionsPadding: EdgeInsets.zero,
                          insetPadding: EdgeInsets.zero,
                          content: Builder(builder: (context) {
                            return Container(
                                height: 600,
                                width: 500,
                                margin: EdgeInsets.all(8),
                                child: CalenderPopUp2());
                          }),
                        );
                      });
                },
                child: CustomTextField(
                    enabled: false,
                    icon: AppImagePath.date,
                    hint: toDate == "noDate" || toDate == ''
                        ? "No Date"
                        : dateFormattor(DateTime.parse(toDate!)),
                    controller: TextEditingController()),
              )),
            ],
          ),
          const Spacer(),
          const Divider(
            thickness: 1.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  onPressed: () {
                    Get.back();
                  },
                  textColor: AppColors.primary,
                  buttonColor: AppColors.lightButton,
                  buttonText: "Cancel",
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomButton(
                  onPressed: () async {
                    await databaseManager.updateEmployee(Employee(
                        id: DateTime.now().microsecondsSinceEpoch,
                        name: nameController.text,
                        role: databaseManager.role.value,
                        toDate: databaseManager.toDate.value,
                        fromDate: databaseManager.fromDate.value));
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Employee Updated")));

                    Get.offAll(() => EmployeeListScreen());
                  },
                  buttonColor: AppColors.primary,
                  buttonText: "Save",
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
