import 'package:employee/main.dart';
import 'package:employee/utils/app_extension.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child:
          Column(mainAxisSize: MainAxisSize.min, children: [
        _roles("Product Designer"),
        _roles("Flutter Developer"),
        _roles("QA Tester"),
        _roles("Product Owner"),
      ]),
    );
  }

  Widget _roles(String role) {
    return GestureDetector(
      onTap: () {
        databaseManager.role.value = role;
        Get.back();
      },
      child: Container(
        color: AppColors.white,
        margin: const EdgeInsets.only(bottom: 1),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(role),
          ],
        ),
      ),
    );
  }
}
