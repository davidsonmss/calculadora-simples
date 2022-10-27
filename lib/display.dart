import 'package:flutter/material.dart';

class Display extends StatefulWidget {
  const Display({
    Key? key,
    required this.display,
  }) : super(key: key);

  final String display;

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  int easterEgg = 0;
  void showEasterEgg(int value, BuildContext context) {
    easterEgg += value;
    if (easterEgg >= 7) {
      easterEgg = 0;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Bahia é o Mundo!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('Um clique');
        showEasterEgg(1, context);
      },
      onDoubleTap: () {
        debugPrint('Duplo clique');
        showEasterEgg(2, context);
      },
      child: Card(
        elevation: 5.0,
        margin: const EdgeInsets.all(20),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(widget.display),
          ),
        ),
      ),
    );
  }
}
