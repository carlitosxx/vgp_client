import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vgp_cliente/constants/colors.dart';
import 'package:vgp_cliente/constants/typography.dart';
import 'package:vgp_cliente/pages/courses_open/models/course_open.model.dart';
import 'package:vgp_cliente/pages/pay/formatters/numeric_formatter.dart';
import 'package:vgp_cliente/pages/pay/service/get_token_credit_card.dart';
import 'package:vgp_cliente/pages/pay/stream/card_stream.dart';
import 'package:vgp_cliente/pages/pay/widgets/credit_card.widget.dart';

class PayCreditCardView extends StatefulWidget {
  const PayCreditCardView({super.key, required this.courseOpen});
  final CourseOpen courseOpen;

  @override
  State<PayCreditCardView> createState() => _PayCreditCardViewState();
}

class _PayCreditCardViewState extends State<PayCreditCardView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> rotateAnimation;
  final controllerNumberCard = TextEditingController();
  final controllerExpiryDate = TextEditingController();
  final controllerName = TextEditingController();
  final controllerCVV = TextEditingController();
  final controllerEmail = TextEditingController();
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    rotateAnimation =
        Tween<double>(begin: 0, end: 1).animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    controllerNumberCard.dispose();
    controllerExpiryDate.dispose();
    controllerName.dispose();
    controllerCVV.dispose();
    controllerEmail.dispose();
    super.dispose();
  }

  final CardStream cardStream = CardStream();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Center(
              child: CreditCardWidget(
            cardStream: cardStream,
            animationController: animationController,
            rotateAnimation: rotateAnimation,
          )),
        ),
        formCreditCardPay(
            animationController: animationController,
            cardStream: cardStream,
            controllerNumberCard: controllerNumberCard,
            controllerCVV: controllerCVV,
            controllerExpiryDate: controllerExpiryDate,
            controllerName: controllerName,
            controllerEmail: controllerEmail,
            courseOpen: widget.courseOpen,
            context: context),
      ],
    );
  }
}

formCreditCardPay(
    {required AnimationController animationController,
    required CardStream cardStream,
    required TextEditingController controllerNumberCard,
    required TextEditingController controllerExpiryDate,
    required TextEditingController controllerCVV,
    required TextEditingController controllerName,
    required TextEditingController controllerEmail,
    required CourseOpen courseOpen,
    required BuildContext context}) {
  return Center(
    child: Container(
      constraints: const BoxConstraints(maxWidth: 600),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'Numero de tarjeta',
              style: TextStyle(fontSize: kH2Size, color: kH2Color),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(.2),
            ),
            child: TextField(
              onTap: () {
                animationController.reverse();
              },
              onChanged: (String value) {
                cardStream.updateNumberCard(value);
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(19),
                CreditCardFormatter(),
              ],
              controller: controllerNumberCard,
              maxLength: 19,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(color: kH3Color, fontSize: kH3Size),
              decoration: InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                  hintText: '0000 0000 0000 0000',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3))),
            ),
          ),
          Row(
            children: [
              Flexible(
                flex: 50,
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: Text(
                        'Vencimiento',
                        style: TextStyle(fontSize: kH2Size, color: kH2Color),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(.2),
                      ),
                      child: TextField(
                        onTap: () {
                          animationController.reverse();
                        },
                        onChanged: (String value) {
                          cardStream.updateExpiryDate(value);
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          ExpiryDateFormatter()
                        ],
                        controller: controllerExpiryDate,
                        maxLength: 5,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: kH3Color, fontSize: kH3Size),
                        decoration: InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            hintText: '00/00',
                            hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.3))),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 50,
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: Text(
                        'CVV',
                        style: TextStyle(fontSize: kH2Size, color: kH2Color),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(.2),
                      ),
                      child: TextField(
                        onTap: () {
                          animationController.forward();
                        },
                        onChanged: (String value) {
                          cardStream.updateCVV(value);
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                        ],
                        controller: controllerCVV,
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: kH3Color, fontSize: kH3Size),
                        decoration: InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            hintText: '000',
                            hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.3))),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          // const Padding(
          //   padding: EdgeInsets.only(bottom: 10, top: 10),
          //   child: Text(
          //     'Nombre y Apellido',
          //     style: TextStyle(fontSize: kH2Size, color: kH2Color),
          //   ),
          // ),
          // Container(
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     color: Colors.white.withOpacity(.2),
          //   ),
          //   child: TextField(
          //     onTap: () {
          //       animationController.reverse();
          //     },
          //     onChanged: (String value) {
          //       cardStream.updateName(value);
          //     },
          //     inputFormatters: [
          //       LengthLimitingTextInputFormatter(20),
          //     ],
          //     controller: controllerName,
          //     maxLength: 20,
          //     keyboardType: TextInputType.name,
          //     textAlign: TextAlign.center,
          //     style: const TextStyle(color: kH3Color, fontSize: kH3Size),
          //     decoration: InputDecoration(
          //         counterText: '',
          //         border: InputBorder.none,
          //         hintText: 'Nombre y Apellido',
          //         hintStyle: TextStyle(color: Colors.white.withOpacity(0.3))),
          //   ),
          // ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: Text(
              'Correo electronico',
              style: TextStyle(fontSize: kH2Size, color: kH2Color),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(.2),
            ),
            child: TextField(
              // onChanged: (String value) {
              //   cardStream.updateName(value);
              // },
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
              ],
              controller: controllerEmail,
              maxLength: 50,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              style: const TextStyle(color: kH3Color, fontSize: kH3Size),
              decoration: InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                  hintText: 'Correo electronico',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3))),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text(
                  'PAGAR S/ ${courseOpen.price}',
                  style: const TextStyle(fontSize: kH1Size, color: kH1Color),
                ),
                onPressed: () async {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) {
                        return Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                            Text('Verificando')
                          ],
                        ));
                      });
                  getTokenCreditCard(
                      context: context,
                      numberCard: controllerNumberCard.text,
                      expiryDate: controllerExpiryDate.text,
                      cvv: controllerCVV.text,
                      email: controllerEmail.text,
                      courseOpenId: courseOpen.id,
                      price: courseOpen.price.toString());
                  // createCharge();

                  // getStudentByEmailAndPassword(
                  //   context: context,
                  //   email: emailController.text,
                  //   password: passwordController.text,);
                }),
          ),
        ],
      ),
    ),
  );
}
