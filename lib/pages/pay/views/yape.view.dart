import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vgp_cliente/constants/colors.dart';
import 'package:vgp_cliente/constants/typography.dart';
import 'package:vgp_cliente/pages/courses_open/models/course_open.model.dart';
import 'package:vgp_cliente/pages/pay/service/get_token_yape.dart';

class YapeView extends StatelessWidget {
  const YapeView({super.key, required this.courseOpen});
  final CourseOpen courseOpen;
  @override
  Widget build(BuildContext context) {
    final controllerCodeOTP = TextEditingController();
    final controllerPhone = TextEditingController();
    final controllerEmail = TextEditingController();
    return Center(
        child: Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'Correo',
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
                  hintText: 'ejemplo@gmail.com',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3))),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: Text(
              'Numero de celular yape',
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
              inputFormatters: [
                LengthLimitingTextInputFormatter(9),
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: controllerPhone,
              maxLength: 9,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(color: kH3Color, fontSize: kH3Size),
              decoration: InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                  hintText: '000 000 000',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3))),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: Text(
              'Código de aprobación',
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
              inputFormatters: [
                LengthLimitingTextInputFormatter(6),
                FilteringTextInputFormatter.digitsOnly
                // CreditCardFormatter(),
              ],
              controller: controllerCodeOTP,
              maxLength: 6,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(color: kH3Color, fontSize: kH3Size),
              decoration: InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                  hintText: '0 0 0 0 0 0',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                const Text(
                  'Encuéntralo en el menú de Yape ',
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                              children: [
                                const Center(
                                    child: Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child:
                                      Text('Ingresa a "Código de aprobanción"'),
                                )),
                                Image.asset(
                                  'assets/others/yape1.jpg',
                                  height: 400,
                                ),
                                const Center(
                                    child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Text('Luego copia el codigo'),
                                )),
                                Image.asset(
                                  'assets/others/yape2.jpg',
                                  height: 400,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10),
                                  child: ElevatedButton(
                                      style: TextButton.styleFrom(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cerrar')),
                                )
                              ],
                            ));
                  },
                  child: Icon(
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
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
                  'YAPEAR S/ ${courseOpen.price}',
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
                  getTokenYape(
                    context: context,
                    price: courseOpen.price.toString(),
                    phone: controllerPhone.text,
                    codeOTP: controllerCodeOTP.text,
                    email: controllerEmail.text,
                    courseOpenId: courseOpen.id,
                  );
                  // getTokenCreditCard(
                  //     context: context,
                  //     numberCard: controllerNumberCard.text,
                  //     expiryDate: controllerExpiryDate.text,
                  //     cvv: controllerCVV.text,
                  //     email: controllerEmail.text,
                  //     courseOpenId: courseOpen.id,
                  //     price: courseOpen.price.toString());
                }),
          ),
        ],
      ),
    ));
  }
}
