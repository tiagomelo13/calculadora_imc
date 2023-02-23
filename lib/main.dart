import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

final TextEditingController controllerPeso = TextEditingController();
final TextEditingController controllerAltura = TextEditingController();

GlobalKey<FormState> _formKey = GlobalKey<FormState>();

String _infoText = 'Informe seus dados';

void _resetFields() {
  controllerPeso.text = '';
  controllerAltura.text = '';
  _infoText = 'Informe seus dados';
}

void _calculate() {

  double peso = double.parse(controllerPeso.text);
  double altura = double.parse(controllerAltura.text) / 100;
  double imc = peso / (altura * altura);

  if (imc < 18.6) {
    _infoText = 'Abaixo do peso (${imc.toStringAsPrecision(4)})';
  } else if (imc >= 18.6 && imc < 25) {
    _infoText = 'Peso normal (${imc.toStringAsPrecision(4)})';
  } else if (imc >= 25 && imc < 30) {
    _infoText = 'Obesidade grau I (${imc.toStringAsPrecision(4)})';
  } else if (imc >= 30 && imc < 35) {
    _infoText = 'Obesidade grau II (${imc.toStringAsPrecision(4)})';
  } else if (imc >= 35 && imc < 40) {
    _infoText = 'Obesidade grau III (${imc.toStringAsPrecision(4)})';
  } else {
    _infoText = 'Baleia (${imc.toStringAsPrecision(4)})';
  }
  print(imc);
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _resetFields();
              });
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person,
                size: 120.0,
                color: Colors.green,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: controllerPeso,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira seu peso';
                    }
                  },
                  cursorColor: Colors.green,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    labelText: 'Peso (Kg)',
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: controllerAltura,
                  cursorColor: Colors.green,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _calculate();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                      'Calcular',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
