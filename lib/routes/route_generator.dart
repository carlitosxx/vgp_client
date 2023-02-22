import 'package:flutter/material.dart';
import 'package:vgp_cliente/pages/category/category.page.dart';
import 'package:vgp_cliente/pages/courses_open/courses_open.page.dart';
import 'package:vgp_cliente/pages/home/home.page.dart';
import 'package:vgp_cliente/pages/login/login.page.dart';
import 'package:vgp_cliente/pages/splash/splash.page.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
     
    switch(settings.name){
      case "/splash":
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case "/login":
        return MaterialPageRoute(builder: (_)=> const LoginPage()); 
      case "/home":
        return MaterialPageRoute(builder: (_)=> const HomePage());
      case"/category":
        return MaterialPageRoute(builder: (_)=> const CategoryPage());
      case "/course-open":
        final args = settings.arguments;
          if (args is String) {
            return MaterialPageRoute(builder: (_)=> CoursesOpenPage(categoryId:args)); 
          }
        return _errorRoute(); 
      default:
        return _errorRoute();       
    }

  }


   static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Ups, ocurrio un error'),
        ),
      );
    });
  }
}