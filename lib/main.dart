import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_skin/view_models/auths_models/auth_view_model.dart';
import 'package:my_skin/view_models/introduction_view_model.dart';
import 'package:my_skin/view_models/scan_view_model.dart';
import 'package:my_skin/view_models/camera_view_model.dart';
import 'package:my_skin/view_models/analysis_view_model.dart';
import 'package:my_skin/views/empathy_screen/empathy_screen.dart';
import 'package:my_skin/views/feature_integration_screens/feature_audit_screen.dart';
import 'package:my_skin/views/welcome_screen/welcome_screen.dart';
import 'package:my_skin/view_models/splash_view_model.dart';
import 'package:my_skin/view_models/subscription_view_model.dart';
import 'package:my_skin/views/introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'core/consts/app_colors.dart';
import 'core/consts/app_fonts.dart';
import 'view_models/welcome_view_model.dart';
import 'view_models/user_info_view_model.dart';
import 'view_models/quote_view_model.dart';
import 'view_models/importance_view_model.dart';
import 'view_models/questionaire_1_view_model.dart';
import 'view_models/questionaire_2_view_model.dart';
import 'view_models/questionaire_3_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WelcomeViewModel()),
        ChangeNotifierProvider(create: (_) => UserInfoViewModel()),
        ChangeNotifierProvider(create: (_) => QuoteViewModel()),
        ChangeNotifierProvider(create: (_) => ImportanceViewModel()),
        ChangeNotifierProvider(create: (_) => IntroductionViewModel()),
        ChangeNotifierProvider(create: (_) => ScanViewModel()),
        ChangeNotifierProvider(create: (_) => CameraViewModel()),
        ChangeNotifierProvider(create: (_) => AnalysisViewModel()),
        ChangeNotifierProvider(create: (_) => Questionaire1ViewModel()),
        ChangeNotifierProvider(create: (_) => Questionaire2ViewModel()),
        ChangeNotifierProvider(create: (_) => Questionaire3ViewModel()),
        ChangeNotifierProvider(create: (_) => SplashViewModel()),
        ChangeNotifierProvider(create: (_) => SubscriptionViewModel()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
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
