import 'package:flutter/material.dart';

typedef NumberPressadCallback = void Function(String);

class NumberButton extends StatelessWidget {
  const NumberButton({
    Key? key,
    required this.number,
    required this.onNumberPressad,
  }) : super(key: key);

  final String number;
  final NumberPressadCallback onNumberPressad;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(shape: const BeveledRectangleBorder()),
        onPressed: (() => onNumberPressad(number)),
        child: Text(number),
      ),
    );
  }
}
