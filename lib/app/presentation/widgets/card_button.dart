import 'package:flutter/material.dart';

class CardButtonWidget extends StatelessWidget {
  const CardButtonWidget(
      {super.key,
      required this.onPressButton,
      required this.textButton,
      this.iconButton});
  final Function() onPressButton;
  final String textButton;
  final IconData? iconButton;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: onPressButton,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (iconButton != null)
                      ? const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.add_card),
                        )
                      : const SizedBox(),
                  Text(
                    'Comprar S/ $textButton',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
