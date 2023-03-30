import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vgp_cliente/app/presentation/pages/home/blocs/user_experience/user_experience.bloc.dart';
import 'package:vgp_cliente/app/presentation/pages/login/blocs/login/login_bloc.dart';
import 'app/my_app.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
  ));

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => di.sl<LoginBloc>(),
      ),
      BlocProvider(
        create: (context) => di.sl<UserExperienceBloc>(),
      ),
    ],
    child: const MyApp(),
  )
      // DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => const MyApp(), // Wrap your app
      // ),
      );
}
