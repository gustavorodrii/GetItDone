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
          print('Requisição: ${options.method} ${options.uri} ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('Resposta: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print(
              'Erro: ${e.response?.statusCode} ${e.message} ${e.response?.data} ${e.response?.statusMessage}');
          return handler.next(e);
        },
      ),
    );
  }
}
