import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vgp_cliente/app/presentation/pages/course/bloc/course_bloc.dart';
import 'package:vgp_cliente/app/presentation/pages/home/blocs/user_experience/user_experience.bloc.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/others/logo2.svg';
    return BlocProvider(
      create: (context) =>
          sl.get<UserExperienceBloc>()..add(const LoadUserExperienceEvent()),
      child: BlocBuilder<UserExperienceBloc, UserExperienceState>(
        builder: (context, state) {
          if (state is UserExperienceLoadingState) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              body: Center(child: SvgPicture.asset(assetName)),
            );
          } else if (state is UserExperienceLoadedState) {
            return const HomePage();
          } else if (state is UserExperienceErrorState) {
            return Text(state.error);
          }
          return Container();
        },
      ),
    );
  }
}
