import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/consts/app_colors.dart';

class AgeDropdown extends StatelessWidget {
  final String label;
  final String hint;
  final String? selectedAge;
  final List<String> ageOptions;
  final ValueChanged<String> onSelected;

  const AgeDropdown({
    super.key,
    required this.label,
    required this.hint,
    required this.selectedAge,
    required this.ageOptions,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showAgePicker(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(16.w, 10.h, 12.w, 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.lightGrey, width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
                color: AppColors.darkGrey,
              ),
            ),
            4.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: Text(
                    selectedAge ?? hint,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: selectedAge != null
                          ? AppColors.black87
                          : AppColors.hintGrey,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.darkGrey,
                  size: 24.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAgePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              12.verticalSpace,
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              16.verticalSpace,
              Text(
                'Select Age',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black87,
                ),
              ),
              12.verticalSpace,
              SizedBox(
                height: 300.h,
                child: ListView.builder(
                  itemCount: ageOptions.length,
                  itemBuilder: (context, index) {
                    final age = ageOptions[index];
                    final isSelected = age == selectedAge;
                    return ListTile(
                      title: Text(
                        age,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w400,
                          color: isSelected
                              ? AppColors.black
                              : AppColors.darkGrey,
                        ),
                      ),
                      onTap: () {
                        onSelected(age);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
