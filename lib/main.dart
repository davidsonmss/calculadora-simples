import 'package:flutter/material.dart';
import 'package:teste/display.dart';
import 'package:teste/theme.dart';
import 'number_button.dart';
import 'operadorButton.dart';

void main() {
  runApp(const MyApp());
}

const appName = 'Calculadora Simples';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode currentThemeMode = ThemeMode.light;

  void toggleThemeMode() {
    setState(() {
      currentThemeMode = currentThemeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: calculadoraSimplesTheme.ligth,
        darkTheme: calculadoraSimplesTheme.dark,
        themeMode: currentThemeMode,
        home: CalculadoraSimples(
          onThemeModePressd: toggleThemeMode,
        ));
  }
}

class CalculadoraSimples extends StatefulWidget {
  const CalculadoraSimples({
    super.key,
    required this.onThemeModePressd,
  });

  final VoidCallback onThemeModePressd;

  @override
  State<CalculadoraSimples> createState() => _CalculadoraSimplesState();
}

class _CalculadoraSimplesState extends State<CalculadoraSimples> {
  static const operadores = ['x', '-', '+'];

  String display = '0';
  String firstNum = '';
  String operador = '';
  String secondNum = '';

  double progress = 0.0;
  bool desableOperadorButton = false;

  void insert(String char) {
    if (char == '0') {
      if (operador.isEmpty && firstNum.isEmpty) return;
      if (operador.isNotEmpty && secondNum.isEmpty) return;
    }

    if (operadores.contains(char)) {
      if (firstNum.isEmpty) {
        firstNum = '0';
      }

      operador = char;
    } else {
      if (operador.isEmpty) {
        firstNum += char;
      } else {
        secondNum += char;
      }
    }

    setState(() {
      if (operador.isEmpty) {
        display = firstNum;
        progress = 0.33;
      } else {
        if (secondNum.isEmpty) {
          display = '$firstNum $operador';
          progress = 0.66;
        } else {
          display = '$firstNum $operador $secondNum';
          progress = 1.0;
          desableOperadorButton = true;
        }
      }
    });
  }

  void clear() {
    firstNum = '';
    operador = '';
    secondNum = '';
    setState(() {
      display = '0';
      progress = 0;
      desableOperadorButton = false;
    });
  }

  void calculate() {
    final number1 = int.parse(firstNum);
    final number2 = int.parse(secondNum);
    int result = 0;

    switch (operador) {
      case 'x':
        result = number1 * number2;
        break;
      case '-':
        result = number1 - number2;
        break;
      default:
        result = number1 + number2;
    }

    firstNum = result.toString();
    secondNum = '';
    operador = '';

    setState(() {
      display = result.toString();
      progress = 0.33;
      desableOperadorButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        actions: [
          IconButton(
            onPressed: widget.onThemeModePressd,
            icon: Icon(theme.brightness == Brightness.light
                ? Icons.dark_mode
                : Icons.light_mode),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 70.0),
        child: FloatingActionButton(
          onPressed: clear,
          child: const Text('C'),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Display(display: display),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: Center(
                child: LinearProgressIndicator(
              backgroundColor: theme.scaffoldBackgroundColor,
              value: progress,
            )),
          ),
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NumberButton(number: '7', onNumberPressad: insert),
              NumberButton(number: '8', onNumberPressad: insert),
              NumberButton(number: '9', onNumberPressad: insert),
              OperadorButton(
                operador: 'x',
                onOperadorPressd: insert,
                disable: desableOperadorButton,
              ),
            ],
          )),
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NumberButton(number: '4', onNumberPressad: insert),
              NumberButton(number: '5', onNumberPressad: insert),
              NumberButton(number: '6', onNumberPressad: insert),
              OperadorButton(
                operador: '-',
                onOperadorPressd: insert,
                disable: desableOperadorButton,
              ),
            ],
          )),
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NumberButton(number: '1', onNumberPressad: insert),
              NumberButton(number: '2', onNumberPressad: insert),
              NumberButton(number: '3', onNumberPressad: insert),
              OperadorButton(
                operador: '+',
                onOperadorPressd: insert,
                disable: desableOperadorButton,
              ),
            ],
          )),
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: TextButton(
                    onPressed: () => insert('0'), child: const Text('0')),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    onPressed: calculate,
                    child: const Text('='),
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
