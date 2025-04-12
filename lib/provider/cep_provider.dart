import 'package:flutter/material.dart';
import 'package:myapp/model/cep_model.dart';
import 'package:myapp/repository/cep_repository.dart';

class CepProvider extends ChangeNotifier {
  CepProvider({required this.repository});

  final CepRepository repository;

  CepModel? _cepData;
  bool _isLoading = false;
  String? _errorMessage = '';
  
  CepModel? get cepData => _cepData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

 Future<void> searchCep(String cep) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      CepModel result = await repository.fetchCep(cep);
      _cepData = result;
    } catch (e) {
      _errorMessage = e.toString();
      _cepData = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}