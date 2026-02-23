import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/consts/app_colors.dart';
import 'core/consts/app_fonts.dart';
import 'view_models/welcome_view_model.dart';
import 'view_models/user_info_view_model.dart';
import 'view_models/quote_view_model.dart';
import 'view_models/importance_view_model.dart';
import 'views/welcome_screen/welcome_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WelcomeViewModel()),
        ChangeNotifierProvider(create: (_) => UserInfoViewModel()),
        ChangeNotifierProvider(create: (_) => QuoteViewModel()),
        ChangeNotifierProvider(create: (_) => ImportanceViewModel()),
      ],
      child: const MySkinApp(),
    ),
  );
}

class MySkinApp extends StatelessWidget {
  const MySkinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'MySkin',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: AppFonts.lato,
            scaffoldBackgroundColor: AppColors.white,
          ),
          home: const WelcomeScreen(),
        );
      },
    );
  }
}
