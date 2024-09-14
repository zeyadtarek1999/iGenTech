import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iGenTech/generated/assets.gen.dart';
import 'package:iGenTech/shared_widgets/custom_drop_down/cubit/custom_drop_down_cubit.dart';
import 'package:iGenTech/core/utils/app_colors.dart';

class CustomRadioDropdown<T> extends StatelessWidget {
  final List<T> items;
  final String hintText;
  final Function(T) onItemSelected;
  final bool withBorders;

  const CustomRadioDropdown({
    super.key,
    required this.items,
    required this.hintText,
    required this.onItemSelected,
    this.withBorders = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropdownCubit<T>, DropdownState<T>>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: AppColors.secondColor,
            borderRadius: BorderRadius.circular(12.r),
            border: withBorders
                ? Border.all(color: AppColors.hintColor)
                : Border.all(color: Colors.transparent),
          ),
          child: DropdownButtonHideUnderline(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0.w),
              child: DropdownButton<T>(
                borderRadius: BorderRadius.circular(12.r),
                isExpanded: true,
                elevation: 3,
                dropdownColor: AppColors.secondColor,
                icon: Padding(
                  padding: EdgeInsets.only(right: 8.0.w),
                  child: SvgPicture.asset(
                    Assets.icons.arrowDown,
                    width: 13.w,
                    height: 13.h,
                  ),
                ),
                hint:  Text(
                  state.selectedItem?.toString() ?? hintText,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: state.selectedItem?.toString() == null ? AppColors.hintColor: AppColors.black,
                  ),
                ),
                onChanged: (T? newValue) {
                  if (newValue != null) {
                    context.read<DropdownCubit<T>>().selectItem(newValue);
                    onItemSelected(newValue);
                  }
                },
                items: items.map((T item) {
                  return DropdownMenuItem<T>(
                    value: item,
                    child: Row(
                      children: [
                        Radio<T>(
                          value: item,
                          groupValue: state.selectedItem,
                          onChanged: (T? newValue) {
                            if (newValue != null) {
                              context.read<DropdownCubit<T>>().selectItem(newValue);
                              onItemSelected(newValue);
                            }
                          },
                          activeColor: AppColors.bgColor,
                        ),
                        Text(
                          item.toString(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
