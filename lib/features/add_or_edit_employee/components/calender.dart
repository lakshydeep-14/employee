import 'dart:ui';

import 'package:employee/main.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../utils/app_extension.dart';

enum DateType {
  today,
  nextMonday,
  nextTuesday,
  afterOneWeek
}

class CalenderPopUp extends StatefulWidget {
  final Function? onTap;
  const CalenderPopUp({super.key, this.onTap});

  @override
  State<CalenderPopUp> createState() =>
      _CalenderPopUpState();
}

class _CalenderPopUpState extends State<CalenderPopUp> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  DateType index = DateType.today;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20),
          child: _calendar(),
        ),
        const Divider(
          thickness: 1.5,
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16.0),
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
                  if (widget.onTap == null) {
                    databaseManager.fromDate.value =
                        _selectedDay.toString();
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
                  textColor: index == DateType.today
                      ? AppColors.white
                      : AppColors.primary,
                  buttonColor: index == DateType.today
                      ? AppColors.primary
                      : AppColors.lightButton,
                  onPressed: () {
                    setState(() {
                      index = DateType.today;
                    });
                    setState(() {
                      _selectedDay = DateTime.now();
                    });
                  },
                  buttonText: 'Today'),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: CustomButton(
                  onPressed: () {
                    setState(() {
                      index = DateType.nextMonday;
                    });
                    if (index != DateType.nextMonday) {
                      if (_selectedDay.weekday == 1) {
                        setState(() {
                          _selectedDay = DateTime.now()
                              .add(const Duration(days: 8));
                        });
                      } else if (_selectedDay.weekday ==
                          2) {
                        setState(() {
                          _selectedDay = DateTime.now()
                              .add(const Duration(days: 7));
                        });
                      } else if (_selectedDay.weekday ==
                          3) {
                        setState(() {
                          _selectedDay = DateTime.now()
                              .add(const Duration(days: 6));
                        });
                      } else if (_selectedDay.weekday ==
                          4) {
                        setState(() {
                          _selectedDay = DateTime.now()
                              .add(const Duration(days: 5));
                        });
                      } else if (_selectedDay.weekday ==
                          5) {
                        setState(() {
                          _selectedDay = DateTime.now()
                              .add(const Duration(days: 4));
                        });
                      } else if (_selectedDay.weekday ==
                          6) {
                        setState(() {
                          _selectedDay = DateTime.now()
                              .add(const Duration(days: 3));
                        });
                      } else {
                        setState(() {
                          _selectedDay = DateTime.now()
                              .add(const Duration(days: 1));
                        });
                      }
                    }
                  },
                  textColor: index == DateType.nextMonday
                      ? AppColors.white
                      : AppColors.primary,
                  buttonColor: index == DateType.nextMonday
                      ? AppColors.primary
                      : AppColors.lightButton,
                  buttonText: 'Next Monday'),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                  onPressed: () {
                    setState(() {
                      index = DateType.nextTuesday;
                    });
                    if (index != DateType.nextTuesday) {
                      if (_selectedDay.weekday == 1) {
                        setState(() {
                          _selectedDay = DateTime.now()
                              .add(const Duration(days: 8));
                        });
                      } else if (_selectedDay.weekday ==
                          2) {
                        setState(() {
                          _selectedDay = DateTime.now()
                              .add(const Duration(days: 7));
                        });
                      } else if (_selectedDay.weekday ==
                          3) {
                        setState(() {
                          _selectedDay = DateTime.now()
                              .add(const Duration(days: 6));
                        });
                      } else if (_selectedDay.weekday ==
                          4) {
                        setState(() {
                          _selectedDay = DateTime.now()
                              .add(const Duration(days: 5));
                        });
                      } else if (_selectedDay.weekday ==
                          5) {
                        setState(() {
                          _selectedDay = DateTime.now()
                              .add(const Duration(days: 4));
                        });
                      } else if (_selectedDay.weekday ==
                          6) {
                        setState(() {
                          _selectedDay = DateTime.now()
                              .add(const Duration(days: 3));
                        });
                      } else {
                        setState(() {
                          _selectedDay = DateTime.now()
                              .add(const Duration(days: 9));
                        });
                      }
                    }
                  },
                  textColor: index == DateType.nextTuesday
                      ? AppColors.white
                      : AppColors.primary,
                  buttonColor: index == DateType.nextTuesday
                      ? AppColors.primary
                      : AppColors.lightButton,
                  buttonText: 'Next Tuesday'),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: CustomButton(
                  onPressed: () {
                    if (index != DateType.afterOneWeek) {
                      setState(() {
                        index = DateType.afterOneWeek;
                        _selectedDay = DateTime.now()
                            .add(const Duration(days: 7));
                      });
                    }
                  },
                  textColor: index == DateType.afterOneWeek
                      ? AppColors.white
                      : AppColors.primary,
                  buttonColor:
                      index == DateType.afterOneWeek
                          ? AppColors.primary
                          : AppColors.lightButton,
                  buttonText: 'After 1 week'),
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
