import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vgp_cliente/app/presentation/pages/home/blocs/user_experience/user_experience.bloc.dart';
import 'package:vgp_cliente/app/presentation/pages/login/blocs/login/login_bloc.dart';
import 'package:vgp_cliente/app/presentation/pages/register/blocs/register/register_bloc.dart';
import 'app/my_app.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
  ));

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<LoginBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<UserExperienceBloc>(),
        ),
        BlocProvider(create: (context) => di.sl<RegisterBloc>())
      ],
      // child: DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => const MyApp(), // Wrap your app
      // ),
      child: const MyApp(),
    ),
  );
}
