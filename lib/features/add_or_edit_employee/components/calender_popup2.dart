import 'package:table_calendar/table_calendar.dart';

import '../../../main.dart';
import '../../../utils/app_extension.dart';

enum DateType2 { today, nodate }

class CalenderPopUp2 extends StatefulWidget {
  const CalenderPopUp2({super.key});

  @override
  State<CalenderPopUp2> createState() => _CalenderPopUp2State();
}

class _CalenderPopUp2State extends State<CalenderPopUp2> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  DateType2 index = DateType2.nodate;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _calendar(),
        ),
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
                onPressed: () {
                  if (index == DateType2.nodate) {
                    databaseManager.toDate.value = "noDate";
                    Get.back();
                  } else {
                    databaseManager.toDate.value = _selectedDay.toString();
                    Get.back();
                  }
                },
                buttonColor: AppColors.primary,
                buttonText: "Save",
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _calendar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomButton(
                  textColor: index == DateType2.nodate
                      ? AppColors.white
                      : AppColors.primary,
                  buttonColor: index == DateType2.nodate
                      ? AppColors.primary
                      : AppColors.lightButton,
                  onPressed: () {
                    setState(() {
                      index = DateType2.nodate;
                    });
                    setState(() {});
                  },
                  buttonText: 'No Date'),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: CustomButton(
                  onPressed: () {
                    setState(() {
                      index = DateType2.today;
                    });
                    if (index != DateType2.today) {
                      setState(() {
                        _selectedDay = DateTime.now();
                      });
                    }
                  },
                  textColor: index == DateType2.today
                      ? AppColors.white
                      : AppColors.primary,
                  buttonColor: index == DateType2.today
                      ? AppColors.primary
                      : AppColors.lightButton,
                  buttonText: 'Today'),
            )
          ],
        ),
        Container(
          height: 400,
          width: double.infinity,
          child: TableCalendar(
            rowHeight: 35,
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2022, 01, 01),
            lastDay: DateTime.utc(2030, 01, 01),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            headerStyle: const HeaderStyle(
              titleTextStyle: TextStyle(
                  color: Color(0xff323238),
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
              headerPadding: EdgeInsets.zero,
              headerMargin: EdgeInsets.only(bottom: 20),
              titleCentered: true,
              formatButtonVisible: false,
              leftChevronIcon: Icon(
                Icons.arrow_left,
                size: 35,
                color: AppColors.hintText,
              ),
              rightChevronIcon: Icon(
                Icons.arrow_right,
                size: 35,
                color: AppColors.hintText,
              ),
            ),
            weekendDays: const <int>[6],
          ),
        ),
      ],
    );
  }
}
