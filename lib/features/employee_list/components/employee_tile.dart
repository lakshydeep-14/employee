import 'package:employee/utils/app_extension.dart';

class EmployeeTile extends StatelessWidget {
  final String name, date, role;
  const EmployeeTile(
      {super.key, required this.name, required this.date, required this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: const EdgeInsets.only(bottom: 1.5),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 6,
            ),
            Text(
              role,
              style: const TextStyle(
                  color: Color(0xff949C9E),
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              date,
              style: const TextStyle(
                  color: Color(0xff949C9E),
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
