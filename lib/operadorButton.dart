// ignore: file_names
import 'package:flutter/material.dart';

typedef OperadorPressedCallBack = void Function(String);

class OperadorButton extends StatelessWidget {
  const OperadorButton({
    required this.operador,
    required this.onOperadorPressd,
    required this.disable,
    Key? key,
  }) : super(key: key);

  final String operador;
  final OperadorPressedCallBack onOperadorPressd;
  final bool disable;

  IconData mapOperadorToIcon() {
    switch (operador) {
      case 'x':
        return Icons.close;
      case '-':
        return Icons.remove;
      default:
        return Icons.add;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: IconButton(
            onPressed: disable ? null : () => onOperadorPressd(operador),
            icon: Icon(mapOperadorToIcon())));
  }
}
