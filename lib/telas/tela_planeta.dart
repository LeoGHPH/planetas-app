import 'package:flutter/material.dart';
import 'package:myapp/controles/controle_planeta.dart';

import '../modelos/planeta.dart';

class TelaPlaneta extends StatefulWidget {
  const TelaPlaneta({super.key});

  @override
  State<TelaPlaneta> createState() => _TelaPlanetaState();
}

class _TelaPlanetaState extends State<TelaPlaneta> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _tamanhoController = TextEditingController();
  final TextEditingController _distanciaController = TextEditingController();
  final TextEditingController _apelidoController = TextEditingController();

  final Planeta _planeta = Planeta.vazio();
  final ControlePlaneta _controlePlaneta = ControlePlaneta();

  @override
  void initState() {
    //_nomeController.text = "";
    //_tamanhoController.text = "12742";
    //_distanciaController.text = "149.600.000";
    //_apelidoController.text = "Home";

    super.initState();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _tamanhoController.dispose();
    _distanciaController.dispose();
    _apelidoController.dispose();

    super.dispose();
  }

  Future<void> _inserirPlaneta() async {
    await _controlePlaneta.inserirPlaneta(_planeta);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Dados validados com sucesso
      _formKey.currentState!.save();
      _inserirPlaneta();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados do planeta salvos com sucesso!\n')),
      );
      Navigator.of(context).pop();

      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 20,
        title: const Text('Cadastrar Planeta'),
        backgroundColor: const Color.fromARGB(255, 111, 178, 234),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,

          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 3) {
                      return 'Por favor, insira o nome do planeta (mais de 3 letras.)';
                    }
                    return null;
                  },
                  onSaved: (newvalue) {
                    _planeta.nome = newvalue!;
                  },
                ),

                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _tamanhoController,
                  decoration: InputDecoration(
                    labelText: 'Tamanho (km)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o tamanho do planeta';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Insira um valor numérico válido';
                    }
                    return null;
                  },
                  onSaved: (newvalue) {
                    _planeta.tamanho = double.parse(newvalue!);
                  },
                ),

                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _distanciaController,
                  decoration: InputDecoration(
                    labelText: 'Distância',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), //
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o tamanho do planeta';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Insira um valor numérico válido';
                    }
                    return null;
                  },
                  onSaved: (newvalue) {
                    _planeta.distancia = double.parse(newvalue!);
                  },
                ),

                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _apelidoController,
                  decoration: InputDecoration(
                    labelText: 'Apelido',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), //
                    ),
                  ),
                  onSaved: (newvalue) {
                    _planeta.apelido = newvalue;
                  },
                ),

                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _submitForm, //submitForm,
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
