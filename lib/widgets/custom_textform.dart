// ignore_for_file: deprecated_member_use, unused_element_parameter

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:my_skin/core/consts/app_colors.dart';
import 'package:my_skin/core/consts/app_fonts.dart';
import 'package:my_skin/core/consts/app_icons.dart';

class CustomTextformWidget extends StatefulWidget {
  final String label;
  final String hint;
  final bool isActive;
  final String value;
  final ValueChanged<String> onChanged;
  final VoidCallback onFocus;
  final VoidCallback? onBlur;
  final VoidCallback? onSubmitted;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool isVisible;
  final VoidCallback? onToggleVisibility;
  final String? errorText;

  const CustomTextformWidget({
    super.key,
    required this.label,
    required this.hint,
    required this.isActive,
    required this.value,
    required this.onChanged,
    required this.onFocus,
    this.onBlur,
    this.onSubmitted,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.isVisible = true,
    this.onToggleVisibility,
    this.errorText,
  });

  @override
  State<CustomTextformWidget> createState() => _CustomTextformWidgetState();
}

class _CustomTextformWidgetState extends State<CustomTextformWidget> {
  late final TextEditingController _controller;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _controller.selection = TextSelection.collapsed(
      offset: _controller.text.length,
    );
  }

  @override
  void didUpdateWidget(covariant CustomTextformWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      final int offset = _controller.selection.baseOffset.clamp(
        0,
        widget.value.length,
      );
      _controller.value = TextEditingValue(
        text: widget.value,
        selection: TextSelection.collapsed(offset: offset),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    // ── Border color logic ─────────────────────────────────────────────────
    Color borderColor;
    if (hasError) {
      borderColor = AppColors.darkGrey;
    } else if (_isFocused && widget.value.isEmpty) {
      borderColor = AppColors.darkGrey.withOpacity(0.3);
    } else if (widget.value.isNotEmpty) {
      borderColor = AppColors.darkGrey;
    } else {
      borderColor = Colors.transparent;
    }

    return Focus(
      onFocusChange: (focused) {
        setState(() => _isFocused = focused);
        if (focused) {
          widget.onFocus();
        } else {
          widget.onBlur?.call();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Text field container ───────────────────────────────
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            decoration: BoxDecoration(
              color: widget.value.isNotEmpty
                  ? Colors.white
                  : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: borderColor, width: 1),
              boxShadow: widget.value.isNotEmpty
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: TextField(
              controller: _controller,
              onChanged: widget.onChanged,
              keyboardType: widget.keyboardType,
              obscureText: widget.isPassword && !widget.isVisible,
              textInputAction: widget.isPassword
                  ? TextInputAction.done
                  : TextInputAction.next,
              onSubmitted: (_) {
                if (widget.onSubmitted != null) {
                  widget.onSubmitted!.call();
                } else {
                  widget.onBlur?.call();
                }
              },
              style: TextStyle(
                fontSize: 18.sp,
                color: AppColors.black,
                fontFamily: AppFonts.lato,
                fontWeight: widget.isPassword
                    ? FontWeight.w500
                    : FontWeight.bold,
              ),
              decoration: InputDecoration(
                labelText: widget.label,
                labelStyle: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  height: 1.2,
                  letterSpacing: 2.3,
                  fontFamily: AppFonts.lato,
                ),
                hintText: widget.hint,
                hintStyle: TextStyle(
                  fontSize: 18.sp,
                  color: AppColors.secondaryGrey,
                  fontFamily: AppFonts.lato,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: widget.isPassword
                    ? GestureDetector(
                        onTap: widget.onToggleVisibility,
                        child: Padding(
                          padding: EdgeInsets.only(right: 14.w, top: 12.h),
                          child: Iconify(
                            widget.isVisible ? AppIcons.show : AppIcons.hiiden,
                            size: 22.w,
                            color: Colors.black45,
                          ),
                        ),
                      )
                    : null,
                suffixIconConstraints: widget.isPassword
                    ? const BoxConstraints()
                    : null,
              ),
            ),
          ),

          // ── Error message ──────────────────────────────────────
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: hasError
                ? Padding(
                    padding: EdgeInsets.only(top: 5.h, left: 4.w),
                    child: Row(
                      children: [
                        Text(
                          widget.errorText!,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppColors.darkGrey,
                            fontFamily: AppFonts.lato,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
