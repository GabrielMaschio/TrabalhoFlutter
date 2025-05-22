import 'package:flutter/material.dart';
import 'package:myapp/model/cep_model.dart';

class CepInfoWidget extends StatelessWidget {
  const CepInfoWidget({super.key, required CepModel cepModel}) : _cepModel = cepModel;

  final CepModel _cepModel;
  @override
  Widget build(BuildContext context) {
    return Card(
  elevation: 5,
  color: const Color.fromARGB(255, 241, 241, 241),
  shadowColor: Colors.black,
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // CEP
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 16),
            children: [
              TextSpan(
                text: 'CEP: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: _cepModel.cep),
            ],
          ),
        ),
        const SizedBox(height: 5),

        // Estado e UF
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 16),
            children: [
              TextSpan(
                text: 'Estado: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: '${_cepModel.estado} - ${_cepModel.uf}'),
            ],
          ),
        ),
        const SizedBox(height: 5),

        // Localidade
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 16),
            children: [
              TextSpan(
                text: 'Localidade: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: _cepModel.localidade),
            ],
          ),
        ),
        const SizedBox(height: 5),

        // Logradouro
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 16),
            children: [
              TextSpan(
                text: 'Logradouro: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: _cepModel.logradouro),
            ],
          ),
        ),
        const SizedBox(height: 5),

        // Bairro
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 16),
            children: [
              TextSpan(
                text: 'Bairro: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: _cepModel.bairro),
            ],
          ),
        ),
      ],
    ),
  ),
);

  }
}
