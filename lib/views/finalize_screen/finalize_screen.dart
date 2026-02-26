// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/views/finalize_screen/finalizes_screen.dart';
import 'package:my_skin/views/finalize_screen/widgets/loading_section.dart';
import 'package:my_skin/views/finalize_screen/widgets/rose_dots_widget.dart';
import 'package:my_skin/views/finalize_screen/widgets/splash_title_section.dart';

class FinalizeScreen extends StatefulWidget {
  const FinalizeScreen({super.key});

  @override
  State<FinalizeScreen> createState() => _FinalizeScreenState();
}

class _FinalizeScreenState extends State<FinalizeScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FinalizesScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 60.h),
            SplashTitleSection(),
            Spacer(),
            RoseDotsWidget(),
            Spacer(),
            LoadingSection(),
            SizedBox(height: 48.h),
          ],
        ),
      ),
    );
  }
}
