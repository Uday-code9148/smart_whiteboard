import 'package:dio/dio.dart';
import 'package:inboard_personal_project/core/wrappers/api_result_wrapper.dart';

class GenericApiService {
  final Dio _dio;

  GenericApiService({BaseOptions? options})
    : _dio = Dio(
        options ??
            BaseOptions(
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
              headers: {'Content-Type': 'application/json'},
            ),
      );

  Future<ApiResult<T>> get<T>({required String url, T Function(dynamic json)? fromJson, Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParams);
      final data = fromJson != null ? fromJson(response.data) : response.data as T;
      return ApiResult.success(data);
    } on DioException catch (e) {
      return ApiResult.failure(_handleDioError(e));
    } catch (e) {
      return ApiResult.failure("Unexpected error: $e");
    }
  }

  Future<ApiResult<T>> post<T>({required String url, Map<String, dynamic>? data, T Function(dynamic json)? fromJson}) async {
    try {
      final response = await _dio.post(url, data: data);
      final result = fromJson != null ? fromJson(response.data) : response.data as T;
      return ApiResult.success(result);
    } on DioException catch (e) {
      return ApiResult.failure(_handleDioError(e));
    } catch (e) {
      return ApiResult.failure("Unexpected error: $e");
    }
  }

  Future<ApiResult<T>> put<T>({required String url, Map<String, dynamic>? data, T Function(dynamic json)? fromJson}) async {
    try {
      final response = await _dio.put(url, data: data);
      final result = fromJson != null ? fromJson(response.data) : response.data as T;
      return ApiResult.success(result);
    } on DioException catch (e) {
      return ApiResult.failure(_handleDioError(e));
    } catch (e) {
      return ApiResult.failure("Unexpected error: $e");
    }
  }

  Future<ApiResult<T>> delete<T>({required String url, T Function(dynamic json)? fromJson}) async {
    try {
      final response = await _dio.delete(url);
      final result = fromJson != null ? fromJson(response.data) : response.data as T;
      return ApiResult.success(result);
    } on DioException catch (e) {
      return ApiResult.failure(_handleDioError(e));
    } catch (e) {
      return ApiResult.failure("Unexpected error: $e");
    }
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return "Connection timeout";
      case DioExceptionType.badResponse:
        return "Bad response: ${e.response?.statusCode}";
      case DioExceptionType.cancel:
        return "Request cancelled";
      case DioExceptionType.connectionError:
        return "No internet connection";
      case DioExceptionType.unknown:
      default:
        return "Unexpected error: ${e.message}";
    }
  }
}
