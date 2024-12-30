import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioService {
  static final DioService _instance = DioService._internal();
  late final Dio dio;

  factory DioService() {
    return _instance;
  }

  DioService._internal() {
    // Carrega o baseUrl do dotenv
    final baseUrl = dotenv.env['BASE_URL'] ?? '';
    if (baseUrl.isEmpty) {
      throw Exception('BASE_URL não encontrado no arquivo .env');
    }

    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    _addInterceptors();
  }

  void _addInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Adicione cabeçalhos ou autenticação, se necessário
          print('Requisição: ${options.method} ${options.uri} ${options.data}');
          return handler.next(options); // Continue com a requisição
        },
        onResponse: (response, handler) {
          print('Resposta: ${response.statusCode} ${response.data}');
          return handler.next(response); // Continue com a resposta
        },
        onError: (DioError e, handler) {
          print(
              'Erro: ${e.response?.statusCode} ${e.message} ${e.response?.data} ${e.response?.statusMessage}');
          return handler.next(e); // Continue com o erro
        },
      ),
    );
  }
}
