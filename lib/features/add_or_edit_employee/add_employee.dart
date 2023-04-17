import 'package:employee/features/add_or_edit_employee/components/calender.dart';
import 'package:employee/features/add_or_edit_employee/components/calender_popup2.dart';
import 'package:employee/features/add_or_edit_employee/components/text_field.dart';
import 'package:employee/features/add_or_edit_employee/edit_employee.dart';
import 'package:employee/features/employee_list/employee_list.dart';
import 'package:employee/utils/app_extension.dart';

import '../../controller/db.dart';
import '../../main.dart';
import 'components/role.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Add Employee Details'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 24),
        child: Column(children: [
          CustomTextField(
              icon: AppImagePath.name,
              hint: "Employee name",
              controller: nameController),
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
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
            child: Obx(
              () => CustomTextField(
                  icon: AppImagePath.role,
                  enabled: false,
                  hint: databaseManager.role.value == ''
                      ? "Select role"
                      : databaseManager.role.value,
                  controller: TextEditingController()),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
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
                    child: Obx(
                      () => CustomTextField(
                          enabled: false,
                          icon: AppImagePath.date,
                          hint: databaseManager.fromDate.value == ""
                              ? "Today"
                              : dateFormattor(DateTime.parse(
                                  databaseManager.fromDate.value)),
                          controller: TextEditingController()),
                    )),
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
                child: Obx(
                  () => CustomTextField(
                      enabled: false,
                      icon: AppImagePath.date,
                      hint: databaseManager.toDate.value == "" ||
                              databaseManager.toDate.value == "noDate"
                          ? "No Date"
                          : dateFormattor(
                              DateTime.parse(databaseManager.toDate.value)),
                      controller: TextEditingController()),
                ),
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
                    print(nameController.text);
                    if (nameController.text.isNotEmpty &&
                        databaseManager.role.value != '' &&
                        databaseManager.role.value == '' &&
                        databaseManager.toDate.value == '' &&
                        databaseManager.fromDate.value == '') {
                      await databaseManager.addEmployee(Employee(
                          id: DateTime.now().microsecondsSinceEpoch,
                          name: nameController.text,
                          role: databaseManager.role.value,
                          toDate: databaseManager.toDate.value,
                          fromDate: databaseManager.fromDate.value));
                      databaseManager.role.value = '';
                      databaseManager.fromDate.value = '';
                      databaseManager.toDate.value = '';
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Employee Added")));

                      Get.offAll(() => EmployeeListScreen());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Fill all fields")));
                    }
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
