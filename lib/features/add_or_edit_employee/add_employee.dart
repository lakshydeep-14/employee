import 'package:employee/features/add_or_edit_employee/components/text_field.dart';
import 'package:employee/utils/app_extension.dart';

import 'components/role.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
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
              controller: TextEditingController()),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.0),
                  ),
                ),
                context: context,
                builder: (BuildContext context) => RoleScreen(),
              );
            },
            child: CustomTextField(
                icon: AppImagePath.role,
                enabled: false,
                hint: "Select role",
                controller: TextEditingController()),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: CustomTextField(
                      icon: AppImagePath.date,
                      hint: "Today",
                      controller: TextEditingController())),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: SvgPicture.asset(AppImagePath.rightArrow),
              ),
              Expanded(
                  child: CustomTextField(
                      icon: AppImagePath.date,
                      hint: "No date",
                      controller: TextEditingController())),
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
                    //clear controller
                  },
                  textColor: AppColors.primary,
                  buttonColor: const Color(0xffEDF8FF),
                  buttonText: "Cancel",
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomButton(
                  onPressed: () {
                    Get.back();
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
