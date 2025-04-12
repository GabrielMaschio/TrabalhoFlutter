import 'package:dio/dio.dart';
import 'package:myapp/model/cep_model.dart';

class CepRepository { 
  CepRepository({Dio? dio}) : _dio = dio ?? Dio();
  
  final Dio _dio;

  Future<CepModel> fetchCep(String cep) async {
    final url = 'https://viacep.com.br/ws/$cep/json/';

    try {
      final response = await _dio.get(url);

      if(response.statusCode == 200) {
        final data = response.data;
        if(data['erro'] != null) {
          throw Exception('CEP não encontrado!');
        }
        return CepModel.fromJson(data);
      } else {
        throw Exception('Erro ao buscar CEP');
      }
    } on DioException catch(e) {
      throw Exception('Erro de conexão: {$e.message}');
    }
  }
}