import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vgp_cliente/app/presentation/pages/course/bloc/course_bloc.dart';
import 'package:vgp_cliente/pages/home/home.page.dart';

import '../../injection_container.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    // veryfyToken();
  }

  // void veryfyToken() async {
  //   var token = await secureStorage.read(key: "token") ?? '';
  //   await Future.delayed(const Duration(seconds: 2), () {
  //     if (token == '') {
  //       Navigator.of(context).pushReplacementNamed('/login');
  //     } else {
  //       // print('hola');
  //       // sl<CourseBloc>()
  //       //     .add(const LoadCourseEvent("f554d155-0c37-4cbb-9612-2580ff7021f5"));
  //       Navigator.of(context).pushReplacementNamed('/home');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    const String assetName = 'assets/others/logo2.svg';
    return BlocProvider(
      create: (context) => sl.get<CourseBloc>()
        ..add(const LoadCourseEvent("f554d155-0c37-4cbb-9612-2580ff7021f5")),
      child: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state is CourseLoadingState) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              body: Center(child: SvgPicture.asset(assetName)),
            );
          } else if (state is CourseLoadedState) {
            return const HomePage();
          } else if (state is CourseErrorState) {
            return Text(state.error);
          }
          return Container();
        },
      ),
    );
  }
}
