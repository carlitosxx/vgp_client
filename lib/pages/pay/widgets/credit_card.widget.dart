import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vgp_cliente/constants/breakpoints.dart';
import 'package:vgp_cliente/constants/typography.dart';
import 'package:vgp_cliente/pages/pay/stream/card_stream.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget(
      {super.key,
      required this.cardStream,
      required this.animationController,
      required this.rotateAnimation});

  final CardStream cardStream;
  final AnimationController animationController;
  final Animation<double> rotateAnimation;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY((rotateAnimation.value < 0.5)
                  ? pi * rotateAnimation.value
                  : (pi * (1 + rotateAnimation.value))),
            child: Stack(
              children: [
                Container(
                  height: 230,
                  width:
                      (size.width <= kMobileSmallMaxWidth) ? size.width : 360,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.secondary),
                  child: StreamBuilder(
                      stream: cardStream.cvvStream,
                      builder: (context, AsyncSnapshot<String> cvvStream) {
                        return StreamBuilder(
                            stream: cardStream.nameStream,
                            builder:
                                (context, AsyncSnapshot<String> nameStream) {
                              return StreamBuilder(
                                  stream: cardStream.expiryDateStream,
                                  builder: (context,
                                      AsyncSnapshot<String> expiryDateStream) {
                                    return StreamBuilder(
                                        stream: cardStream.numberCardStream,
                                        builder: (context,
                                            AsyncSnapshot<String>
                                                numberCardStream) {
                                          return Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child:
                                                  (rotateAnimation.value < 0.5)
                                                      ? frontCard(
                                                          numberCardStream,
                                                          expiryDateStream,
                                                          nameStream)
                                                      : backCard(cvvStream));
                                        });
                                  });
                            });
                      }),
                ),
                (rotateAnimation.value < 0.5)
                    ? Positioned(
                        bottom: 15,
                        right: 10,
                        child: SvgPicture.asset(
                          'assets/others/visa.svg',
                          width: 100,
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          );
        });
  }

  Column backCard(AsyncSnapshot<String> cvvStream) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          color: Colors.black,
          height: 50,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(left: 0),
                color: Colors.white70,
                height: 50,
                width: 180,
              ),
            ),
            Flexible(
              child: Container(
                color: Colors.white,
                height: 30,
                width: 50,
                child: Center(child: Text(cvvStream.data ?? '')),
              ),
            ),
            // Container()
          ],
        ),
      ],
    );
  }

  Column frontCard(
      AsyncSnapshot<String> numberCardStream,
      AsyncSnapshot<String> expiryDateStream,
      AsyncSnapshot<String> nameStream) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Text('Visa Classic Crédito',
                style:
                    TextStyle(fontSize: kH1Size, fontWeight: FontWeight.bold)),
          ),
          SvgPicture.asset(
            'assets/others/chip2.svg',
            height: 45,
          ),
          AutoSizeText(numberCardStream.data ?? '',
              maxLines: 1,
              style: const TextStyle(
                  fontSize: kH0Size, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 2, left: 80),
                child: Column(
                  children: const [
                    Text('VALIDO',
                        style: TextStyle(
                            fontSize: kH6Size, fontWeight: FontWeight.bold)),
                    Text('HASTA',
                        style: TextStyle(
                            fontSize: kH6Size, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              Text(expiryDateStream.data ?? '',
                  style: const TextStyle(fontSize: 25))
            ],
          ),
          AutoSizeText(nameStream.data ?? '',
              maxLines: 1, style: const TextStyle(fontSize: 18))
        ]);
  }
}
