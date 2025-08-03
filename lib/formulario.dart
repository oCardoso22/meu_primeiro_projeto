import 'package:flutter/material.dart';

class formulario extends StatefulWidget {
  const formulario({super.key});

  @override
  State<formulario> createState() => _formularioState();
}

class _formularioState extends State<formulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  DateTime? _dataNascimento;
  String? _sexoSelecionado;

  Future<void> _selecionarData() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dataNascimento) {
      setState(() {
        _dataNascimento = picked;
      });
    }
  }

  bool _validarIdade() {
    if (_dataNascimento == null) return false;
    final hoje = DateTime.now();
    int idade = hoje.year - _dataNascimento!.year;
    if (hoje.month < _dataNascimento!.month ||
        (hoje.month == _dataNascimento!.month && hoje.day < _dataNascimento!.day)) {
      idade--;
    }
    return idade >= 18;
  }

  void _enviarFormulario() {
    if (_formKey.currentState!.validate()) {
      if (!_validarIdade()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('É necessário ter mais de 18 anos.')),
        );
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulário')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome Completo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome completo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(_dataNascimento == null
                    ? 'Selecionar Data de Nascimento'
                    : 'Data de Nascimento: ${_dataNascimento!.day}/${_dataNascimento!.month}/${_dataNascimento!.year}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: _selecionarData,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Sexo'),
                items: const [
                  DropdownMenuItem(value: 'Homem', child: Text('Homem')),
                  DropdownMenuItem(value: 'Mulher', child: Text('Mulher')),
                ],
                onChanged: (value) {
                  setState(() {
                    _sexoSelecionado = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecione o sexo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _enviarFormulario,
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
