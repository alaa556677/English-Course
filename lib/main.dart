import 'package:english/Features/home/presentation/cubit/home_cubit.dart';
import 'package:english/core/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Features/home/presentation/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size (360,690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child){
          return MaterialApp(
            title: 'Learning English',
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
            theme: lightTheme,
            themeMode: ThemeMode.light,
          );
        },
      )
    );
  }
}

