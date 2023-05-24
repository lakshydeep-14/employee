import 'package:employee/controller/db.dart';
import 'package:employee/features/add_or_edit_employee/edit_employee.dart';
import 'package:employee/main.dart';
import 'package:employee/utils/app_extension.dart';
import 'package:intl/intl.dart';

class EmployeeTile extends StatefulWidget {
  final Employee employee;
  const EmployeeTile({super.key, required this.employee});

  @override
  State<EmployeeTile> createState() => _EmployeeTileState();
}

class _EmployeeTileState extends State<EmployeeTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
            EditEmployeeScreen(employee: widget.employee));
      },
      child: Dismissible(
        background: Container(
          color: Colors.red,
          margin:
              const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.only(right: 20),
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        key: Key(widget.employee.id.toString() +
            DateTime.now().toString()),
        direction: DismissDirection.endToStart,
        onDismissed: (_) async {
          await databaseManager
              .deleteemployee(widget.employee.id!);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Employee Deleted")));
          databaseManager.readEmployee();
        },
        child: Container(
          color: AppColors.white,
          margin: const EdgeInsets.only(bottom: 1.5),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text(
              widget.employee.name!,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 6,
                ),
                Text(
                  widget.employee.role!,
                  style: const TextStyle(
                      color: Color(0xff949C9E),
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  "From " +
                      dateFormattor(DateTime.parse(
                          widget.employee.fromDate!)),
                  style: const TextStyle(
                      color: Color(0xff949C9E),
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
                (widget.employee.toDate == "noDate" ||
                        widget.employee.toDate == '')
                    ? const Text(
                        "  ",
                        style: TextStyle(
                            color: Color(0xff949C9E),
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      )
                    : Text(
                        " - " +
                            dateFormattor(DateTime.parse(
                                widget.employee.toDate!)),
                        style: const TextStyle(
                            color: Color(0xff949C9E),
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
