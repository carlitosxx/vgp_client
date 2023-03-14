import 'package:flutter/material.dart';
import 'package:vgp_cliente/pages/courses_open/models/course_open.model.dart';

class DepositOrTransferView extends StatelessWidget {
  const DepositOrTransferView({super.key, required this.courseOpen});
  final CourseOpen courseOpen;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Puede depositar o transferir a cualquiera de nuestras cuentas de ahorro en soles, el beneficiario es PRINGSTOM E.I.R.L. luego debe enviar una foto del comprobante de pago al numero de Whatsapp 917946993.'),
            const ListTile(
              leading: Icon(Icons.savings),
              title: Text('Banco de credito del Perú'),
              subtitle: Text('000-9841469-0-74'),
            ),
            const ListTile(
              leading: Icon(Icons.savings),
              title: Text('Interbank'),
              subtitle: Text('000-9841469-0-74'),
            ),
            const ListTile(
              leading: Icon(Icons.savings),
              title: Text('ScotiaBank'),
              subtitle: Text('000-9841469-0-74'),
            ),
            const ListTile(
              leading: Icon(Icons.savings),
              title: Text('BBVA'),
              subtitle: Text('000-9841469-0-74'),
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
                  onPressed: null,
                  child: Text(
                    'PAGAR S/ ${courseOpen.price}',
                    // style: const TextStyle(fontSize: kH1Size, color: kH1Color),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
