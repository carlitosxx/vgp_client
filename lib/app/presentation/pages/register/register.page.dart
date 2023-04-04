import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vgp_cliente/app/core/utils/show_dialog.dart';
import 'package:vgp_cliente/app/presentation/pages/home/blocs/user_experience/user_experience.bloc.dart';
import 'package:vgp_cliente/app/presentation/pages/login/widgets/input.dart';
import 'package:vgp_cliente/app/presentation/pages/register/blocs/register/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();
  bool termAndConditionsChckbox = false;
  @override
  Widget build(BuildContext context) {
    Size kSize = MediaQuery.of(context).size;
    double ancho = kSize.width;
    return GestureDetector(
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
                      flex: 70,
                      fit: FlexFit.tight,
                      child: Center(
                        child: Container(
                            constraints: BoxConstraints(
                              minWidth: 300,
                              maxWidth: (ancho < 1024) ? 412 : 712,
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'REGÍSTRATE',
                                    style: TextStyle(
                                      fontSize: (ancho < 412)
                                          ? ancho * 0.09
                                          : ancho * 0.05,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  inputWidget(
                                      hintText: 'NOMBRES',
                                      maxLength: 100,
                                      textInputType: TextInputType.name,
                                      controller: firstNameController,
                                      marginHorizontal: 0),
                                  inputWidget(
                                      hintText: 'APELLIDOS',
                                      maxLength: 100,
                                      textInputType: TextInputType.name,
                                      controller: lastNameController,
                                      marginHorizontal: 0),
                                  inputWidget(
                                      hintText: 'CORREO ELECTRÓNICO',
                                      maxLength: 100,
                                      textInputType: TextInputType.emailAddress,
                                      controller: emailController,
                                      marginHorizontal: 0),
                                  inputWidget(
                                      hintText: 'CONTRASEÑA',
                                      maxLength: 12,
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      controller: passwordController,
                                      marginHorizontal: 0),
                                  inputWidget(
                                      hintText: 'CONFIRME SU CONTRASEÑA',
                                      maxLength: 12,
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      controller: repasswordController,
                                      marginHorizontal: 0),
                                  Row(
                                    children: [
                                      Checkbox(
                                          activeColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          value: termAndConditionsChckbox,
                                          onChanged: (newValue) {
                                            setState(() {
                                              termAndConditionsChckbox =
                                                  newValue!;
                                            });
                                          }),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                                text: 'Yo acepto los '),
                                            TextSpan(
                                              text: 'Terminos y Condiciones',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const WidgetError(),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: BottonRegister(
                                          emailController: emailController,
                                          passwordController:
                                              passwordController,
                                          firstNameController:
                                              firstNameController,
                                          lastNameController:
                                              lastNameController,
                                          repasswordController:
                                              repasswordController,
                                          termAndConditionsChckbox:
                                              termAndConditionsChckbox,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("¿Ya tienes una cuenta?"),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Identifícate',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ))
                                    ],
                                  ),
                                ])),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}

class BottonRegister extends StatelessWidget {
  const BottonRegister(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.repasswordController,
      required this.firstNameController,
      required this.lastNameController,
      required this.termAndConditionsChckbox});

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController repasswordController;
  final bool termAndConditionsChckbox;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: ((context, state) {
        state.whenOrNull(loaded: ((register) {
          context
              .read<UserExperienceBloc>()
              .add(const LoadUserExperienceEvent());
          Navigator.of(context).pushReplacementNamed('/home');
        }));
      }),
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          error: (error) => ElevatedButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text(
                'REGISTRAR',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () {
                if (emailController.text == '' ||
                    passwordController.text == '' ||
                    firstNameController.text == '' ||
                    lastNameController.text == '' ||
                    repasswordController.text == '') {
                  showDialogAlert(
                      context: context,
                      message: 'No deje ningun campo vacio',
                      seconds: 3);
                } else {
                  if (!termAndConditionsChckbox) {
                    showDialogAlert(
                        context: context,
                        message: 'Debe aceptar los termino y condiciones',
                        seconds: 3);
                  } else {
                    if (repasswordController.text != passwordController.text) {
                      showDialogAlert(
                          context: context,
                          message: 'Las contraseñas no coinciden',
                          seconds: 3);
                    } else {
                      context.read<RegisterBloc>().add(RegisterEvent.load(
                          firstNameController.text,
                          lastNameController.text,
                          emailController.text,
                          passwordController.text));
                    }
                  }
                }
              }),
          initial: (() => ElevatedButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text(
                'REGISTRAR',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () {
                if (emailController.text == '' ||
                    passwordController.text == '' ||
                    firstNameController.text == '' ||
                    lastNameController.text == '' ||
                    repasswordController.text == '') {
                  showDialogAlert(
                      context: context,
                      message: 'No deje ningun campo vacio',
                      seconds: 3);
                } else {
                  if (!termAndConditionsChckbox) {
                    showDialogAlert(
                        context: context,
                        message: 'Debe aceptar los termino y condiciones',
                        seconds: 3);
                  } else {
                    if (repasswordController.text != passwordController.text) {
                      showDialogAlert(
                          context: context,
                          message: 'Las contraseñas no concuerdan',
                          seconds: 3);
                    } else {
                      context.read<RegisterBloc>().add(RegisterEvent.load(
                          firstNameController.text,
                          lastNameController.text,
                          emailController.text,
                          passwordController.text));
                    }
                  }
                }
              })),
          loading: () => ElevatedButton(
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
              )),
        );
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
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return state.maybeWhen(
          orElse: () => const SizedBox(
              // height: 40,
              ),
          error: ((error) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  error,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              )));
    });
  }
}
