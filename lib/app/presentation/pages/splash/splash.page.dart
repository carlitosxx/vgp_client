import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vgp_cliente/app/presentation/pages/home/blocs/user_experience/user_experience.bloc.dart';
import 'package:vgp_cliente/app/presentation/pages/home/home.page.dart';
import 'package:vgp_cliente/app/presentation/pages/login/login.page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/others/logo2.svg';
    context.read<UserExperienceBloc>().add(const LoadUserExperienceEvent());

    return BlocBuilder<UserExperienceBloc, UserExperienceState>(
      builder: (context, state) {
        if (state is UserExperienceLoadingState) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Center(child: SvgPicture.asset(assetName)),
          );
        } else if (state is UserExperienceLoadedState) {
          return const HomePage();
        } else if (state is UserExperienceErrorState) {
          return const LoginPage();
        }
        return Container();
      },
    );
  }
}
