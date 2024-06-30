import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:health/data/model/diagnose_result.dart';
import 'package:health/ui/routes/result/result.state.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit() : super(const ResultState());

  final _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['URL'] ?? '',
  ))
    ..interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ))
    ..httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        return HttpClient()
          ..badCertificateCallback = (cert, host, port) => true;
      },
      validateCertificate: (certificate, host, port) => true,
    );

  Future<void> load(String path) async {
    emit(state.copyWith(status: 1));
    try {
      final response = await _dio.post(
        '/detect',
        data: FormData.fromMap({
          'img': await MultipartFile.fromFile(path),
        }),
      );
      emit(state.copyWith(
        status: 0,
        result: DiagnoseResult.fromJson(response.data),
      ));
    } catch (_) {
      emit(state.copyWith(status: -1));
    }
  }
}
