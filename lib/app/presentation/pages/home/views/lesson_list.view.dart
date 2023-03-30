import 'package:flutter/material.dart';

import 'package:vgp_cliente/app/presentation/pages/home/customPaint/stage_zero.cp.dart';
import 'package:vgp_cliente/app/presentation/pages/home/utils/get_decimals.dart';
// import 'package:vgp_cliente/pages/home/utils/get_decimals.dart';

class LessonListView extends StatefulWidget {
  const LessonListView({super.key});

  @override
  State<LessonListView> createState() => _LessonListViewState();
}

class _LessonListViewState extends State<LessonListView> {
  String gemaRojo = 'assets/icons/gema_rojo.svg';
  String gemaVerde = 'assets/icons/gema_verde.svg';
  String gemaAzul = 'assets/icons/gema_azul.svg';
  String chaos = 'assets/icons/chaos.svg';
  String menu = 'assets/icons/menu.svg';
  @override
  Widget build(BuildContext context) {
    int value = 1;
    List<Widget> items = List.generate(100, (i) {
      i = i + 1;
      final divideByFour = i / 4;
      if (!isInteger(divideByFour)) {
        if (divideByFour.toString().split('.')[1] == '25') {
          value = 1;
        }
      }
      final dividedByEight = i / 8;
      if (!isInteger(dividedByEight)) {
        if (dividedByEight.toString().split('.')[1] == '75') {
          value = 4;
        }
        if (dividedByEight.toString().split('.')[1] == '875') {
          value = 5;
        }
        if (dividedByEight.toString().split('.')[1] == '25' ||
            dividedByEight.toString().split('.')[1] == '5') {
          value = 2;
        }
        if (dividedByEight.toString().split('.')[1] == '375') {
          value = 3;
        }
      } else {
        value = 4;
      }
      return Padding(
        padding: EdgeInsets.only(
            bottom: 15,
            left: (value == 2)
                ? 100.0
                : (value == 3)
                    ? 160.00
                    : 00,
            right: (value == 4)
                ? 100.0
                : (value == 5)
                    ? 160.00
                    : 00),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const StageZeroCP(
                width: 85,
                colorBase: Color(0xFF38464f),
                colorShadow: Color(0xff2c3941)),
            Positioned(child: Text('$i')),
          ],
        ),
      );
    });
    return Scaffold(
        body: ListView(
      children: items,
    ));
  }
}

//Add this
