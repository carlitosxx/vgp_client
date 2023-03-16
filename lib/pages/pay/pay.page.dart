import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vgp_cliente/constants/colors.dart';
import 'package:vgp_cliente/constants/typography.dart';
import 'package:vgp_cliente/pages/courses_open/models/course_open.model.dart';
import 'package:vgp_cliente/pages/pay/views/deposit_transfer.view.dart';
import 'package:vgp_cliente/pages/pay/views/pay_credit_card.view.dart';
import 'package:vgp_cliente/pages/pay/views/yape.view.dart';

class PayPage extends StatefulWidget {
  const PayPage({super.key, required this.courseOpen});
  final CourseOpen courseOpen;

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  final PageStorageBucket bucket = PageStorageBucket();
  late Widget currentScreen;
  int _value = 1;
  String yape = 'assets/icons/yape.svg';
  @override
  void initState() {
    currentScreen = PayCreditCardView(
      courseOpen: widget.courseOpen,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pago del curso'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: AutoSizeText(
                        'Metodo de Pago',
                        style: TextStyle(fontSize: kH2Size, color: kH2Color),
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).colorScheme.onBackground),
                      child: Column(
                        children: [
                          RadioListTile(
                            title: Row(
                              children: const [
                                Icon(
                                  Icons.credit_card,
                                  size: kH0Size,
                                ),
                                Expanded(
                                  child: AutoSizeText(
                                    '  Tarjeta de crédito/debito',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: kH3Size,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            groupValue: _value,
                            value: 1,
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                                currentScreen = PayCreditCardView(
                                  courseOpen: widget.courseOpen,
                                );
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            title: Row(
                              children: const [
                                Icon(
                                  Icons.account_balance,
                                  size: kH0Size,
                                ),
                                Expanded(
                                  child: AutoSizeText(
                                    '  Deposito o transferencia',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: kH3Size,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            groupValue: _value,
                            value: 2,
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                                currentScreen = DepositOrTransferView(
                                  courseOpen: widget.courseOpen,
                                );
                              });
                            },
                          ),
                          RadioListTile(
                            dense: true,
                            title: Row(
                              children: [
                                SvgPicture.asset(
                                  yape,
                                  width: 30,
                                  // color: Theme.of(context).iconTheme.color
                                ),
                                const Expanded(
                                  child: AutoSizeText(
                                    '  Yape en linea',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: kH3Size,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            groupValue: _value,
                            value: 3,
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                                currentScreen = YapeView(
                                  courseOpen: widget.courseOpen,
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              PageStorage(bucket: bucket, child: currentScreen),
            ],
          ),
        ),
      ),
    );
  }
}
