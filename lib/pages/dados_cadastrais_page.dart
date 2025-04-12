import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/pages/main_page.dart';
import 'package:myapp/widget/button_widget.dart';

class DadosCadastraisPage extends StatefulWidget {
  const DadosCadastraisPage({super.key});

  @override
  State<DadosCadastraisPage> createState() => _DadosCadastraisPageState();
}

class _DadosCadastraisPageState extends State<DadosCadastraisPage> {
  final _formGlobalKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final dateController = TextEditingController();

  DateTime? birthDate;
  String selectedLevel = '', name = '';
  List<String> selectedLanguages = [];
  int experienceTime = 1;
  double salary = 0.0;
  bool saving = false;

  final List<String> levels = ['Iniciante', 'Intermediário', 'Avançado'];
  final List<String> languages = ['Dart', 'Flutter', 'JavaScript', 'Python'];

  @override
  void initState() {
    super.initState();
    selectedLevel = levels.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados Cadastrais'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      // Utilizamos um Stack para sobrepor o formulário com o loading
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formGlobalKey,
              child: Column(
                children: [
                  buildCustomTextFormField(
                    label: 'Nome',
                    validator: (value) {
                      if (value == null || value.length < 4) {
                        return 'O nome deve ter pelo menos 4 caracteres!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // Exemplo: name = value!;
                    },
                    maxLength: 28,
                  ),
                  buildCustomDateFormField(
                    context,
                    label: 'Data de Nascimento',
                    controller: dateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Selecione a data de nascimento!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        birthDate = value != null ? DateFormat('dd/MM/yyyy').parse(value) : null;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  buildCustomRadioWidget(
                    label: 'Nível de Experiência',
                    options: levels,
                    selectedValue: selectedLevel,
                    optionLabel: (option) => option,
                    onChanged: (value) => setState(() => selectedLevel = value.toString()),
                  ),
                  SizedBox(height: 20),
                  buildLanguagesCheckbox(
                    label: 'Linguagens Preferidas',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Selecione pelo menos uma linguagem!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  buildExperienceDropdown(
                    label: 'Tempo de Experiência',
                  ),
                  SizedBox(height: 20),
                  buildSalarySlider(
                    label: 'Pretensão Salarial',
                  ),
                  SizedBox(height: 20),
                  buildSubmit(),
                ],
              ),
            ),
          ),
          // Overlay de loading: exibido quando "saving" é true
          if (saving)
            Container(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildCustomTextFormField({
    required String label,
    required String? Function(String?) validator,
    required void Function(String?) onSaved,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
          validator: validator,
          onSaved: onSaved,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLength: maxLength,
        ),
      ],
    );
  }

  Widget buildCustomDateFormField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required void Function(String?) onSaved,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            suffixIcon: Icon(Icons.calendar_today),
          ),
          validator: validator,
          onSaved: onSaved,
          readOnly: true,
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
              locale: const Locale('pt', 'BR'),
            );
            if (pickedDate != null) {
              controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
            }
          },
        ),
      ],
    );
  }

  Widget buildCustomRadioWidget<T>({
    required String label,
    required List<T> options,
    required T selectedValue,
    required String Function(T) optionLabel,
    required ValueChanged<T?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ...options.map(
          (option) => RadioListTile<T>(
            title: Text(optionLabel(option)),
            value: option,
            groupValue: selectedValue,
            onChanged: onChanged,
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
        ),
      ],
    );
  }

  Widget buildLanguagesCheckbox({
    required String label,
    required String? Function(List<String>?) validator,
  }) {
    return FormField<List<String>>(
      initialValue: selectedLanguages,
      validator: validator,
      builder: (formFieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                  fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ...languages.map((lang) {
              return CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(lang),
                value: selectedLanguages.contains(lang),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedLanguages.add(lang);
                    } else {
                      selectedLanguages.remove(lang);
                    }
                    formFieldState.didChange(selectedLanguages);
                  });
                },
              );
            }),
            if (formFieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  formFieldState.errorText!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget buildExperienceDropdown({
    required String label,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        SizedBox(
          child: DropdownMenu<int>(
            width: double.infinity,
            initialSelection: experienceTime,
            dropdownMenuEntries: List.generate(15, (index) {
              return DropdownMenuEntry<int>(
                value: index + 1,
                label: '${index + 1} ano(s)',
              );
            }),
            onSelected: (int? newValue) {
              if (newValue != null) {
                setState(() {
                  experienceTime = newValue;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget buildSalarySlider({
    required String label,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Slider(
          value: salary,
          min: 0,
          max: 20000,
          divisions: 100,
          label: 'R\$ ${salary.toStringAsFixed(0)}',
          onChanged: (double value) {
            setState(() {
              salary = value;
            });
          },
        ),
        Text(
          'R\$ ${salary.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget buildSubmit() => Builder(
        builder: (context) => ButtonWidget(
          text: 'Salvar',
          onClicked: () async {
            final formState = _formGlobalKey.currentState;
            if (formState != null && formState.validate()) {
              formState.save();
              // Ativa o efeito de loading
              setState(() {
                saving = true;
              });
              // Simula um processo assíncrono (como salvar dados no servidor)
              await Future.delayed(Duration(seconds: 2));
              // Desativa o loading
              setState(() {
                saving = false;
              });
              final message = 'Dados salvos com sucesso!';
              DelightToastBar(builder: (context) {
                return ToastCard(
                    leading: Icon(Icons.notifications, size: 32, color: Colors.black87),
                    title: Text(
                      message,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                                      
                  );
              },
                position: DelightSnackbarPosition.top,
                autoDismiss: true,
                snackbarDuration: Duration(seconds: 3),
              // ignore: use_build_context_synchronously
              ).show(context);
              // Redireciona para a tela principal
              Navigator.pushReplacement(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            }
          },
        ),
      );
}
