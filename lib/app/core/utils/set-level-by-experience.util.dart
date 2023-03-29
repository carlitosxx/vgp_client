import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

Widget setLevelByExperience(int experience) {
  String asset = 'assets/levels/1.svg';
  if (experience >= 0 && experience <= 100) {
    asset = 'assets/levels/1.svg';
  }
  if (experience >= 101 && experience <= 200) {
    asset = 'assets/levels/2.svg';
  }
  if (experience >= 201 && experience <= 300) {
    asset = 'assets/levels/3.svg';
  }
  if (experience >= 301 && experience <= 400) {
    asset = 'assets/levels/4.svg';
  }
  if (experience >= 401 && experience <= 500) {
    asset = 'assets/levels/5.svg';
  }
  if (experience >= 501 && experience <= 600) {
    asset = 'assets/levels/6.svg';
  }
  if (experience >= 601 && experience <= 700) {
    asset = 'assets/levels/7.svg';
  }
  if (experience >= 701 && experience <= 800) {
    asset = 'assets/levels/8.svg';
  }
  if (experience >= 801 && experience <= 900) {
    asset = 'assets/levels/9.svg';
  }
  if (experience >= 901 && experience <= 1000) {
    asset = 'assets/levels/10.svg';
  }

  return SvgPicture.asset(
    asset,
    height: 50,
    width: 50,
  );
}
