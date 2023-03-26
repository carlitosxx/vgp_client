import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vgp_cliente/app/data/repositories_impl/course_repository_impl.dart';
import 'package:vgp_cliente/app/data/datasource/remote/course.datasource.dart';
import 'package:vgp_cliente/app/domain/repositories/course_repository.dart';
import 'package:vgp_cliente/pages/category/bloc/category/category_bloc.dart';
import 'package:vgp_cliente/pages/category/repositories/category.repository.dart';
import 'package:vgp_cliente/pages/courses_open/bloc/courses_open_bloc.dart';
import 'package:vgp_cliente/pages/courses_open/repositories/courses_open.repository.dart';
import 'package:vgp_cliente/pages/login/bloc/login_bloc.dart';
import 'package:vgp_cliente/pages/pay/bloc/pay_bloc.dart';
import 'package:vgp_cliente/routes/route_generator.dart';

import 'presentation/pages/course/bloc/course_bloc.dart';
import 'package:dio/dio.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider<CategoryBloc>(
            create: (_) => CategoryBloc(CategoryRepository())),
        BlocProvider<CoursesOpenBloc>(
            create: (_) => CoursesOpenBloc(CoursesOpenRepository())),
        BlocProvider<PayBloc>(create: (_) => PayBloc()),
        // BlocProvider<CourseBloc>(
        //     create: (_) => CourseBloc(CourseRepositoryImpl(CourseApi(Dio()))))
      ],
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff005d4c),
            ),
          ),
          primaryColor: const Color(0Xff00A884),
          colorScheme: const ColorScheme(
            background: Color(0xFF111B21),
            onBackground: Color(0xff202C33),
            brightness: Brightness.dark,
            error: Color.fromARGB(100, 201, 63, 9),
            onError: Color.fromARGB(255, 230, 215, 17),
            onPrimary: Color.fromARGB(255, 163, 170, 169),
            onSecondary: Color.fromARGB(255, 240, 12, 137),
            primary: Color(0xffAEBAC1),
            secondary: Color(0xff005d4c),
            tertiary: Color(0xffEB455F),
            //appbar
            surface: Color(0xff202C33),
            onSurface: Color(0xffAEBAC1),
          ),
        ),
        initialRoute: '/splash',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
