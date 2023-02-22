import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vgp_cliente/pages/login/service/get_student_by_email_and_password.dart';
import 'package:vgp_cliente/pages/login/widgets/input.dart';
// import 'package:vgp_cliente/widgets/dialog.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FlutterSecureStorage secureStorage=const FlutterSecureStorage();
  final emailController =TextEditingController();
  final passwordController =TextEditingController();
  @override
  void initState() {
    super.initState();    
  }
  @override
  Widget build(BuildContext context) {
    
    const String assetName = 'assets/others/logo2.svg';
    final Size kSize=MediaQuery.of(context).size;
    double ancho=kSize.width; 
    return WillPopScope(
      onWillPop: ()async=>false,
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
                    flex:40,
                    fit:FlexFit.tight,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [                        
                        SvgPicture.asset(
                          assetName,
                          width: 300,
                          height: (ancho<800)?300:600, 
                        ),
                      ],
                    ) 
                  ),
                  Flexible(
                    flex:60,
                    fit:FlexFit.tight,
                    child:Container(
                      constraints: BoxConstraints(
                        minWidth: 300,
                        maxWidth: (ancho<1024)?412:712,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [ //TEXTO EMPECEMOS
                           Text('COMENCEMOS',
                            style: TextStyle(
                                fontSize: (ancho<412)?ancho*0.09:ancho*0.05,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                ), 
                          ),
                          const SizedBox(height: 20,),
                    //INPUTS
                        inputWidget(
                          hintText: 'INGRESE SU CORREO',
                          maxLength: 100,
                          textInputType: TextInputType.emailAddress,
                          controller: emailController,
                          marginHorizontal:ancho*0.01
                          ),
                        inputWidget(
                          hintText: 'INGRESE SU CLAVE',
                          maxLength: 12,
                          textInputType: TextInputType.visiblePassword,
                          controller: passwordController,
                          marginHorizontal:ancho*0.01
                          ),
                    //BOTON
                     //BOTON 'SIGUIENTE'
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: double.infinity,                              
                                  child: ElevatedButton(
                                    style: TextButton.styleFrom(
                                        padding:
                                            const EdgeInsets.symmetric(vertical: 15),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    child: const Text(
                                      'SIGUIENTE',
                                      style: TextStyle(fontSize: 20,color: Colors.white),
                                    ),
                                    onPressed: ()async{                                      
                                      showDialog(barrierDismissible: false,context: context, builder: (_){                                        
                                        return const Center(child: CircularProgressIndicator());
                                      });
                                      getStudentByEmailAndPassword(
                                        context: context,
                                        email: emailController.text,
                                        password: passwordController.text,);                                      
                                    }                                
                                 
                                  ),
                                ),
                              ],
                            ),
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