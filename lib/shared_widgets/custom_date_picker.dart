import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:iGenTech/core/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:iGenTech/generated/locale_keys.g.dart';

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const CustomDatePicker({
    super.key,
    required this.onDateSelected,
  });

  @override
  CustomDatePickerState createState() => CustomDatePickerState();
}

class CustomDatePickerState extends State<CustomDatePicker> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  void _showMonthPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: 12,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                _getMonthName(index + 1),
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                setState(() {
                  _focusedDay = DateTime(_focusedDay.year, index + 1, _focusedDay.day);
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return LocaleKeys.months_january.tr();
      case 2:
        return LocaleKeys.months_february.tr();
      case 3:
        return LocaleKeys.months_march.tr();
      case 4:
        return LocaleKeys.months_april.tr();
      case 5:
        return LocaleKeys.months_may.tr();
      case 6:
        return LocaleKeys.months_june.tr();
      case 7:
        return LocaleKeys.months_july.tr();
      case 8:
        return LocaleKeys.months_august.tr();
      case 9:
        return LocaleKeys.months_september.tr();
      case 10:
        return LocaleKeys.months_october.tr();
      case 11:
        return LocaleKeys.months_november.tr();
      case 12:
        return LocaleKeys.months_december.tr();
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.secondColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _focusedDay = DateTime(
                        _focusedDay.year,
                        _focusedDay.month - 1,
                        _focusedDay.day,
                      );
                    });
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    color: AppColors.bgColor,
                  ),
                ),
                GestureDetector(
                  onTap: () => _showMonthPicker(context),
                  child: Text(
                    _getMonthName(_focusedDay.month),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.bgColor,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _focusedDay = DateTime(
                        _focusedDay.year,
                        _focusedDay.month + 1,
                        _focusedDay.day,
                      );
                    });
                  },
                  icon: Icon(
                    Icons.chevron_right,
                    color: AppColors.bgColor,
                  ),
                ),
              ],
            ),
            TableCalendar(
              firstDay: DateTime.utc(2000),
              lastDay: DateTime.utc(2100),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });

                widget.onDateSelected(selectedDay);
                Navigator.pop(context, selectedDay);
              },
              headerVisible: false,
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: AppColors.bgColor,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: AppColors.hintColor,
                  shape: BoxShape.circle,
                ),
                defaultTextStyle: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 16.sp,
                ),
                weekendTextStyle: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 16.sp,
                ),
                outsideTextStyle: TextStyle(
                  color: AppColors.hintColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 16.sp,
                ),
                selectedTextStyle: TextStyle(
                  color: AppColors.secTextColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: AppColors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
                weekendStyle: TextStyle(
                  color: AppColors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
