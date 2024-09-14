import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:iGenTech/core/utils/app_colors.dart';

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
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.bgColor,
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: AppColors.bgColor,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: AppColors.bgColor,
                ),
              ),
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
