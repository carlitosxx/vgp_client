import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  FlutterSecureStorage secureStorage=const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
     veryfyToken();   
    
  }
  void veryfyToken()async{
    var token= await secureStorage.read(key: "token") ?? '';     
    await Future.delayed(const Duration(seconds: 2), () {
      if(token == '') {        
        Navigator.of(context).pushReplacementNamed('/login');
      }else{        
        Navigator.of(context).pushReplacementNamed('/home');  
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/others/logo2.svg';
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SvgPicture.asset(
          assetName
        )),
    );
  }
}