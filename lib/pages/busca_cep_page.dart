import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:myapp/provider/cep_provider.dart';
import 'package:myapp/widget/button_widget.dart';
import 'package:myapp/widget/cep_info_widget.dart';
import 'package:provider/provider.dart';

class BuscaCep extends StatefulWidget {
  const BuscaCep({super.key});

  @override
  State<BuscaCep> createState() => _BuscaCepState();
}

class _BuscaCepState extends State<BuscaCep> {
  final _formKey = GlobalKey<FormState>();
  final _cepController = TextEditingController();
  final cepMaskFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: { "#": RegExp(r'\d') },
  );

  @override
  void dispose() {
    _cepController.dispose();
    super.dispose();
  }

  Widget buildSubmit() {
    return Builder(
      builder: (context) {
        return ButtonWidget(
          text: 'Buscar',
          onClicked: () async {
            if (!_formKey.currentState!.validate()) return;

            // pegando o provider *sem* listen
            final provider = Provider.of<CepProvider>(context, listen: false);

            // dispara a busca e aguarda
            await provider.searchCep(cepMaskFormatter.getUnmaskedText());

            // mostra toast de acordo com o resultado
            if (provider.errorMessage != null) {
              DelightToastBar(
                builder: (_) => ToastCard(
                  leading: Icon(Icons.error_outline, size: 32, color: Colors.red),
                  title: Text(provider.errorMessage!,
                      style: TextStyle(fontSize: 14, color: Colors.black)),
                ),
                position: DelightSnackbarPosition.top,
                autoDismiss: true,
                snackbarDuration: Duration(seconds: 3),
              ).show(context);
            } else {
              DelightToastBar(
                builder: (_) => ToastCard(
                  leading: Icon(Icons.check_circle, size: 32, color: Colors.green),
                  title: Text('CEP encontrado com sucesso!',
                      style: TextStyle(fontSize: 14, color: Colors.black)),
                ),
                position: DelightSnackbarPosition.top,
                autoDismiss: true,
                snackbarDuration: Duration(seconds: 3),
              ).show(context);
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // aqui sim escutamos as mudanças
    final provider = context.watch<CepProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar CEP'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Icon(Icons.map, size: 48),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _cepController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [cepMaskFormatter],
                    decoration: InputDecoration(
                      labelText: 'Digite o seu CEP',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o CEP';
                      }
                      if (value.length != 9) {
                        return 'CEP inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  buildSubmit(),
                  const SizedBox(height: 20),
                  if (provider.cepData != null)
                    CepInfoWidget(cepModel: provider.cepData!),
                ],
              ),
            ),
          ),

          if (provider.isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
