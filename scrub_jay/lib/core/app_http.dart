import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class AppHttp {
  AppHttp._();

  static AppHttp appHttp = AppHttp._();

  Future<http.Response?> postRequest(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final Uri uri = Uri.parse(url);

    try {
      final http.Response response = await http.post(
        uri,
        headers: headers,
        body: body,
        encoding: encoding,
      );

      return response;
    } on http.ClientException catch (e) {
      log(e.message);
      return null;
    }
  }

  Future<http.Response?> getRequest(
    String url, [
    Map<String, String>? headers,
  ]) async {
    final Uri uri = Uri.parse(url);

    try {
      final http.Response response = await http.get(
        uri,
        headers: headers,
      );

      return response;
    } on http.ClientException catch (e) {
      log(e.message);
      return null;
    }
  }

  Future<http.Response?> patchRequest(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final Uri uri = Uri.parse(url);

    try {
      final http.Response response = await http.patch(
        uri,
        headers: headers,
      );

      return response;
    } on http.ClientException catch (e) {
      log(e.message);
      return null;
    }
  }
}
