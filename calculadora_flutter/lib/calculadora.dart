import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerB = TextEditingController();

  String _operation = '+';
  String _resultText = '';

  @override
  void dispose() {
    _controllerA.dispose();
    _controllerB.dispose();
    super.dispose();
  }

  double? _parseNumber(String text) {
    if (text.trim().isEmpty) return null;
    final normalized = text.replaceAll(',', '.');
    return double.tryParse(normalized);
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;

    final a = _parseNumber(_controllerA.text)!;
    final b = _parseNumber(_controllerB.text)!;

    double res;
    String resStr;

    switch (_operation) {
      case '+':
        res = a + b;
        resStr = res.toString();
        break;
      case '-':
        res = a - b;
        resStr = res.toString();
        break;
      case '×':
        res = a * b;
        resStr = res.toString();
        break;
      case '÷':
        if (b == 0) {
          setState(() {
            _resultText = 'Erro: divisão por zero';
          });
          return;
        }
        res = a / b;
        resStr = res.toString();
        break;
      default:
        resStr = 'Operação inválida';
    }

    setState(() {
      _resultText = resStr;
    });
  }

  void _clear() {
    _controllerA.clear();
    _controllerB.clear();
    setState(() {
      _resultText = '';
      _operation = '+';
    });
  }

  Widget _buildNumberField(
      {required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Informe um número';
        }
        if (_parseNumber(value) == null) {
          return 'Número inválido';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Calculadora'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildNumberField(controller: _controllerA),
              Align(
                alignment: Alignment.center,
                child: DropdownButton<String>(
                  value: _operation,
                  items: const [
                    DropdownMenuItem(value: '+', child: Text('+')),
                    DropdownMenuItem(value: '-', child: Text('-')),
                    DropdownMenuItem(value: '×', child: Text('×')),
                    DropdownMenuItem(value: '÷', child: Text('÷')),
                  ],
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() {
                      _operation = v;
                    });
                  },
                ),
              ),
              _buildNumberField(controller: _controllerB),
              Row(
                children: [
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: _calculate,
                    child: const Text('Calcular'),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: _clear,
                    child: const Text('Limpar'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Resultado',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(
                        _resultText,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
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