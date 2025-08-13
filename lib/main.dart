import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carrossel de Formulários',
      debugShowCheckedModeBanner: false,
      home: const FormCarouselPage(),
    );
  }
}

class FormData {
  String nomeCompleto;
  DateTime? dataNascimento;
  String sexo;

  FormData({
    this.nomeCompleto = '',
    this.dataNascimento,
    this.sexo = '',
  });
}

class FormCarouselPage extends StatefulWidget {
  const FormCarouselPage({super.key});

  @override
  State<FormCarouselPage> createState() => _FormCarouselPageState();
}

class _FormCarouselPageState extends State<FormCarouselPage> {
  final PageController _pageController = PageController();
  final List<FormData> _forms = [FormData()];
  int _currentIndex = 0;

  void _addNewForm() {
    setState(() {
      _forms.add(FormData());
      _currentIndex = _forms.length - 1;
    });
    _pageController.animateToPage(_currentIndex, duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _updateForm(int index, String field, dynamic value) {
    setState(() {
      switch (field) {
        case 'nome':
          _forms[index].nomeCompleto = value;
          break;
        case 'data':
          _forms[index].dataNascimento = value;
          break;
        case 'sexo':
          _forms[index].sexo = value;
          break;
      }
    });
  }

  Future<void> _selectDate(int index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _forms[index].dataNascimento ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _updateForm(index, 'data', picked);
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Selecionar data';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulários'),
      ),
      body: Column(
        children: [
          Text('${_currentIndex + 1} de ${_forms.length}'),

          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemCount: _forms.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('Pessoa ${index + 1}', style: const TextStyle(fontSize: 20)),
                      const SizedBox(height: 20),

                      TextField(
                        onChanged: (value) => _updateForm(index, 'nome', value),
                        decoration: const InputDecoration(labelText: 'Nome Completo'),
                      ),
                      const SizedBox(height: 16),

                      GestureDetector(
                        onTap: () => _selectDate(index),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(border: Border.all()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_formatDate(_forms[index].dataNascimento)),
                              const Icon(Icons.calendar_today),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      DropdownButton<String>(
                        value: _forms[index].sexo.isEmpty ? null : _forms[index].sexo,
                        hint: const Text('Selecione o sexo'),
                        isExpanded: true,
                        onChanged: (value) => _updateForm(index, 'sexo', value ?? ''),
                        items: const [
                          DropdownMenuItem(value: 'Homem', child: Text('Homem')),
                          DropdownMenuItem(value: 'Mulher', child: Text('Mulher')),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _forms.length,
                  (index) => Container(
                margin: const EdgeInsets.all(4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? Colors.blue : Colors.grey,
                ),
              ),
            ),
          ),

          ElevatedButton(
            onPressed: _addNewForm,
            child: const Text('Adicionar'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}