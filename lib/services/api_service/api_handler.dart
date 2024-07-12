import 'package:fixa/fixa_main_routes.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  // (POST)
  Future<ResponseModel<http.Response>> postRequestMethod(
      {required Map<String, String> headers,
      required dynamic body,
      required String endPoint}) async {
    try {
      final response = await http.post(Uri.parse(endPoint),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        return ResponseModel(
            response: response, error: false, errorMessage: null);
      } else {
        return ResponseModel(
            response: response, error: true, errorMessage: response.body);
      }
    } catch (e) {
      return ResponseModel(
          response: null, error: true, errorMessage: e.toString());
    }
  }

  // (GET)
  Future<ResponseModel<http.Response>> getRequestMethod(
      {required Map<String, String> headers, required String endPoint}) async {
    try {
      final response = await http.get(
        Uri.parse(endPoint),
        headers: headers,
      );
      if (response.statusCode == 200) {
        return ResponseModel(
            response: response, error: false, errorMessage: null);
      } else {
        return ResponseModel(
            response: response, error: true, errorMessage: null);
      }
    } catch (e) {
      return ResponseModel(
          response: null, error: true, errorMessage: e.toString());
    }
  }

  // (PUT)
  Future<ResponseModel<http.Response>> putRequestMethod(
      {required Map<String, String> headers,
      required dynamic body,
      required String endPoint}) async {
    try {
      final response = await http.put(Uri.parse(endPoint),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        return ResponseModel(
            response: response, error: false, errorMessage: null);
      } else {
        return ResponseModel(
            response: response, error: true, errorMessage: response.body);
      }
    } catch (e) {
      return ResponseModel(
          response: null, error: true, errorMessage: e.toString());
    }
  }

  // (DELETE)
  Future<ResponseModel<http.Response>> deleteRequestMethod(
      {required Map<String, String> headers, required String endPoint}) async {
    try {
      final response = await http.delete(Uri.parse(endPoint), headers: headers);
      if (response.statusCode == 200) {
        return ResponseModel(
            response: response, error: false, errorMessage: null);
      } else {
        return ResponseModel(
            response: response, error: true, errorMessage: response.body);
      }
    } catch (e) {
      return ResponseModel(
          response: null, error: true, errorMessage: e.toString());
    }
  }

  // (Auth_request)
  Future<ResponseModel<http.Response>> signIn(
      {required String email,
      required String password,
      required String endPoint}) async {
    try {
      final response = await http.post(Uri.parse(endPoint),
          body: {"identifier": email, "password": password});
      if (response.statusCode == 200) {
        return ResponseModel(
            response: response, error: false, errorMessage: null);
      } else {
        return ResponseModel(
            response: response, error: true, errorMessage: jsonDecode(response.body)['error']);
      }
    } catch (e) {
      return ResponseModel(
          response: null, error: true, errorMessage: e.toString());
    }
  }
}
