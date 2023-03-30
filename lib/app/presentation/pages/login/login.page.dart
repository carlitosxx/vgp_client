import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vgp_cliente/app/core/utils/show_dialog.dart';
import 'package:vgp_cliente/app/presentation/pages/home/blocs/user_experience/user_experience.bloc.dart';

import 'package:vgp_cliente/app/presentation/pages/login/blocs/login/login_bloc.dart';

import 'package:vgp_cliente/app/presentation/pages/login/widgets/input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/others/logo2.svg';
    final Size kSize = MediaQuery.of(context).size;
    double ancho = kSize.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            color: Theme.of(context).colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Flexible(
                      flex: 30,
                      fit: FlexFit.tight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            assetName,
                            width: 300,
                            height: (ancho < 800) ? 300 : 600,
                          ),
                        ],
                      )),
                  Flexible(
                    flex: 70,
                    fit: FlexFit.tight,
                    child: Container(
                      constraints: BoxConstraints(
                        minWidth: 300,
                        maxWidth: (ancho < 1024) ? 412 : 712,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //TEXTO EMPECEMOS
                          Text(
                            'IDENTIFICATE',
                            style: TextStyle(
                              fontSize:
                                  (ancho < 412) ? ancho * 0.09 : ancho * 0.05,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          //INPUTS
                          inputWidget(
                              hintText: 'INGRESE SU CORREO',
                              maxLength: 100,
                              textInputType: TextInputType.emailAddress,
                              controller: emailController,
                              marginHorizontal: 0),
                          inputWidget(
                              hintText: 'INGRESE SU CLAVE',
                              maxLength: 12,
                              textInputType: TextInputType.visiblePassword,
                              controller: passwordController,
                              marginHorizontal: 0),
                          // ERROR
                          const WidgetError(),
                          //BOTON 'SIGUIENTE'
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: BottonLogin(
                                    emailController: emailController,
                                    passwordController: passwordController),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottonLogin extends StatelessWidget {
  const BottonLogin({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoadedState) {
          context
              .read<UserExperienceBloc>()
              .add(const LoadUserExperienceEvent());
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      builder: (context, state) {
        //! initial state login
        if (state is LoginInitialState) {
          return ElevatedButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text(
                'SIGUIENTE',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () {
                if (emailController.text == '' ||
                    passwordController.text == '') {
                  showDialogAlert(
                      context: context,
                      message: 'Debe ingresar el correo y la clave',
                      seconds: 3);
                } else {
                  context.read<LoginBloc>().add(LoadLoginEvent(
                      emailController.text, passwordController.text));
                }
              });
        }
        //! loading state login
        if (state is LoginLoadingState) {
          return ElevatedButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: null,
              child: Row(
                children: const [
                  Expanded(
                      flex: 1,
                      child: Center(child: CircularProgressIndicator())),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        'CARGANDO',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                ],
              ));
        }
        //! cargado state login
        if (state is LoginLoadedState) {
          return ElevatedButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text(
                'SIGUIENTE',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () {
                if (emailController.text == '' ||
                    passwordController.text == '') {
                  showDialogAlert(
                      context: context,
                      message: 'esta enviando campos vacios',
                      seconds: 3);
                } else {
                  context.read<LoginBloc>().add(LoadLoginEvent(
                      emailController.text, passwordController.text));
                }
              });
        }
        //! error state login
        if (state is LoginErrorState) {
          return ElevatedButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text(
                'SIGUIENTE',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () {
                if (emailController.text == '' ||
                    passwordController.text == '') {
                  showDialogAlert(
                      context: context,
                      message: 'esta enviando campos vacios',
                      seconds: 3);
                } else {
                  context.read<LoginBloc>().add(LoadLoginEvent(
                      emailController.text, passwordController.text));
                }
              });
        }
        return Container();
      },
    );
  }
}

class WidgetError extends StatelessWidget {
  const WidgetError({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (state is LoginErrorState) {
        return Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
          child: Text(
            state.error,
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        );
      }
      return const SizedBox(
        height: 40,
      );
    });
  }
}
