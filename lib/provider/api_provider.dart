import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:rehab_web/utils/constants.dart';
import 'package:get_storage/get_storage.dart';

const PRINT_DIO = false;

class ApiProvider {
  final String apiBaseUrl = "ec2-3-137-144-122.us-east-2.compute.amazonaws.com:8080/";
  BaseOptions options = BaseOptions(
    receiveTimeout: API_TIMEOUT,
    connectTimeout: API_TIMEOUT,
    sendTimeout: API_TIMEOUT,
  );
  Dio _dio;
  String token;

  static final ApiProvider instance = new ApiProvider._internal();

  factory ApiProvider() {
    return instance;
  }

  ApiProvider._internal() {
    _dio = Dio(options);

    _setupInterceptor();
  }

  void _setupInterceptor() {
    int maxCharactersPerLine = 200;
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions op, request) {},
    ));
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options, request) {
      options.connectTimeout = API_TIMEOUT;
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      print("--> ${options.method} ${options.path}");
      print("Content type: ${options.contentType}");
      print("Header: ${options.headers}");
      printBody(options);
      print("--> END HTTP");
      return options; //continue
    }, onResponse: (response, request) {
      // printResponse(response, maxCharactersPerLine);
      return response; // continue
    }, onError: (DioError e, request) {
      if (e.response.statusCode == 401 && Get.routing.current != '/LoginPage' && Get.routing.current != '/') {
        token = null;
        GetStorage box = GetStorage();
        box.remove('token');
        if (!Get.isSnackbarOpen) Get.snackbar('Error', 'Your token has expired', instantInit: false);
      }
      print(e);
      return e;
    }));
  }

  void printBody(RequestOptions options) {
    if (!PRINT_DIO) return;
    print("Body: ${options.data}");
  }

  void printError(DioError e, int maxCharactersPerLine) {
    if (!PRINT_DIO) return;
    if (e.response != null) {
      print("<-- ERRROR ${e.response.statusCode} ${e.response.data.method} ${e.response.data.request.path}");
      String responseAsString = e.response.data.toString();
      if (responseAsString.length > maxCharactersPerLine) {
        int iterations = (responseAsString.length / maxCharactersPerLine).floor();
        for (int i = 0; i <= iterations; i++) {
          int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
          if (endingIndex > responseAsString.length) {
            endingIndex = responseAsString.length;
          }
          print(responseAsString.substring(i * maxCharactersPerLine, endingIndex));
        }
      } else {
        print(e.response.data);
      }
      print("<-- ERROR END HTTP");
    }
  }

  void printResponse(response, int maxCharactersPerLine) {
    if (!PRINT_DIO) return;
    print("<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
    String responseAsString = response.data.toString();
    if (responseAsString.length > maxCharactersPerLine) {
      int iterations = (responseAsString.length / maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        print(responseAsString.substring(i * maxCharactersPerLine, endingIndex));
      }
    } else {
      print(response.data);
    }
    print("<-- END HTTP");
  }

  Future<dynamic> get(String path) async {
    return _dio.get(apiBaseUrl + path);
  }

  Future<dynamic> post(String path, dynamic data) async {
    return _dio.post(apiBaseUrl + path, data: data);
  }

  Future<dynamic> patch(String path, dynamic data) async {
    return _dio.patch(apiBaseUrl + path, data: data);
  }

  Future<dynamic> delete(String path) async {
    return _dio.delete(apiBaseUrl + path);
  }
}
