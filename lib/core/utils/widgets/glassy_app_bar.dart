import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlassyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color backgroundColor;
  final double blurSigma;

  const GlassyAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor = Colors.transparent,
    this.blurSigma = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leading: leading,
      actions: actions,
      backgroundColor: backgroundColor,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      toolbarHeight: title == null && leading == null && actions == null
          ? 0
          : kToolbarHeight,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(color: Colors.white.withValues(alpha: 0.1)),
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
    if (title == null && leading == null && actions == null) {
      return const Size.fromHeight(0);
    }
    return const Size.fromHeight(kToolbarHeight);
  }
}
