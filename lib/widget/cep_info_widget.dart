import 'package:flutter/material.dart';
import 'package:myapp/model/cep_model.dart';

class CepInfoWidget extends StatelessWidget {
  const CepInfoWidget({super.key, required CepModel cepModel}) : _cepModel = cepModel;

  final CepModel _cepModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.redAccent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('CEP: ${_cepModel.cep}'),
            const SizedBox(height: 5),
            Text('Logradouro: ${_cepModel.logradouro}'),
            Text('Bairro: ${_cepModel.bairro}'),
            Text('Localidade: ${_cepModel.localidade}'),
            Text('UF: ${_cepModel.uf}'),
            Text('Estado: ${_cepModel.estado}'),
          ],
        ),
      ),
    );
  }
}
