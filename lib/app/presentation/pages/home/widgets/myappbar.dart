import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight) * 1;
}

class _MyAppBarState extends State<MyAppBar> {
  String gemaRojo = 'assets/icons/gema_rojo.svg';
  String gemaVerde = 'assets/icons/gema_verde.svg';
  String gemaAzul = 'assets/icons/gema_azul.svg';
  String chaos = 'assets/icons/chaos.svg';
  String menu = 'assets/icons/menu.svg';
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              bottom: BorderSide(
                //                   <--- left side
                color: Theme.of(context).colorScheme.background,
                width: 2.0,
              ),
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
                flex: 10,
                child: GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: SizedBox(
                      child: SvgPicture.asset(
                    menu,
                    width: 30,
                  )),
                )),
            Flexible(
                flex: 90,
                fit: FlexFit.loose,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Container(),

                  // SizedBox(
                  //   // margin: EdgeInsets.symmetric(vertical: 20),
                  //   width: 200,
                  //   height: 20,
                  //   child: ClipRRect(
                  //     clipBehavior: Clip.antiAliasWithSaveLayer,
                  //     borderRadius: BorderRadius.all(Radius.circular(25)),
                  //     child: LinearProgressIndicator(
                  //       value: 0.7,
                  //       valueColor: AlwaysStoppedAnimation<Color>(
                  //           Theme.of(context).colorScheme.secondary),
                  //       backgroundColor: Color(0xffD6D6D6),
                  //     ),
                  //   ),
                  // )

                  //  Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Expanded(
                  //       child: IconButton(
                  //           onPressed: () {},
                  //           icon: SvgPicture.asset(
                  //             gemaRojo,
                  //             width: 30,
                  //           )),
                  //     ),
                  //     const Text('0'),
                  //     Expanded(
                  //       child: IconButton(
                  //           onPressed: () {},
                  //           icon: SvgPicture.asset(
                  //             gemaAzul,
                  //             width: 30,
                  //           )),
                  //     ),
                  //     const Text('0'),
                  //     Expanded(
                  //       child: IconButton(
                  //           onPressed: () {},
                  //           icon: SvgPicture.asset(
                  //             gemaVerde,
                  //             width: 30,
                  //           )),
                  //     ),
                  //     const Text('300'),
                  //     Expanded(
                  //       child: IconButton(
                  //           onPressed: () {},
                  //           icon: SvgPicture.asset(
                  //             chaos,
                  //             width: 22,
                  //           )),
                  //     ),
                  //     const Text('0'),
                  //   ],
                  // ),
                )),
          ],
        ));
  }
}
