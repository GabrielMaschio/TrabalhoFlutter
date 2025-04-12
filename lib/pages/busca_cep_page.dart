import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:myapp/widget/button_widget.dart';

class BuscaCep extends StatefulWidget {
  const BuscaCep({super.key});

  @override
  State<BuscaCep> createState() => _BuscaCepState();
}

class _BuscaCepState extends State<BuscaCep> {
  bool searching = false;
  final _formKey = GlobalKey<FormState>();

  final cepMaskFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: { "#": RegExp(r'\d') },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar CEP'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey, // Associa o Form com o GlobalKey
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 48.0),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Digite o seu CEP',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [cepMaskFormatter],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o CEP';
                      }
                      if (value.length != 9) {
                        return 'CEP inválido';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      //final cep = cepMaskFormatter.getUnmaskedText();
                      // Salve o CEP conforme necessário
                    },
                  ),
                  SizedBox(height: 20),
                  buildSubmit(),
                ],
              ),
            ),
          ),
          if (searching)
            Container(
              width: double.infinity,
              height: double.infinity,
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildSubmit() => Builder(
        builder: (context) => ButtonWidget(
          text: 'Buscar',
          onClicked: () async {
            // Chama a validação de todos os campos do Form
            if (_formKey.currentState != null && _formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              // Ativa o efeito de loading
              setState(() {
                searching = true;
              });
              await Future.delayed(Duration(seconds: 2));
              setState(() {
                searching = false;
              });
              final message = 'Dados encontrados com sucesso!';
              DelightToastBar(
                builder: (context) {
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
            }
          },
        ),
      );
}
