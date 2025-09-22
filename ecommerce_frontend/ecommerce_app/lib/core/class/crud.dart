import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/functions/checkinternet.dart';
import 'package:ecommerce_app/core/services/services.dart'; // <-- needed for MyServices
//import 'package:ecommerce_app/linkapi.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Crud {
  MyServices myServices = Get.find();

  // Common helper to build headers with optional Authorization token
  Map<String, String> _buildHeaders({bool withAuth = true}) {
    final headers = {"Content-Type": "application/json"};
    if (withAuth) {
      final token = myServices.sharedPreferences.getString("token");
      if (token != null && token.isNotEmpty) {
        headers["Authorization"] = "Token $token";
      }
    }
    return headers;
  }

  //------ POST ----------
  Future<Either<StatusRequest, Map>> postData(
    String linkUrl,
    Map<String, dynamic> data, {
    bool withAuth = true,
  }) async {
    try {
      if (!await checkInternet()) {
        return const Left(StatusRequest.offlineFailure);
      }

      final response = await http.post(
        Uri.parse(linkUrl),
        body: jsonEncode(data),
        headers: _buildHeaders(withAuth: withAuth),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body) as Map;
        return Right(responseBody);
      }

      print("HTTP ${response.statusCode} ${response.reasonPhrase}");
      print("URL: $linkUrl");
      print("Request body: $data");
      print("Response raw: ${response.body}");
      print('Access token: ${myServices.sharedPreferences.getString("token")}');

      return const Left(StatusRequest.serverFailure);
    } catch (e) {
      print("Exception in POST: $e");
      return const Left(StatusRequest.failure);
    }
  }

  //--------- GET --------------- -- -
  Future<Either<StatusRequest, dynamic>> getData(String linkUrl) async {
    try {
      if (!await checkInternet()) {
        return const Left(StatusRequest.offlineFailure);
      }

      final response = await http.get(
        Uri.parse(linkUrl),
        headers: _buildHeaders(),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body);
        return Right(responseBody);
      }

      print("HTTP ${response.statusCode} ${response.reasonPhrase}");
      print("URL: $linkUrl");
      print("Response raw: ${response.body}");
      return const Left(StatusRequest.serverFailure);
    } catch (e) {
      print("Exception in GET: $e");
      return const Left(StatusRequest.failure);
    }
  }

  // Future<bool> refreshToken() async {
  //   final refresh = myServices.sharedPreferences.getString('refresh');
  //   if (refresh == null) return false;

  //   final res = await http.post(
  //     Uri.parse(AppLink.refreshToken),
  //     body: jsonEncode({'refresh': refresh}),
  //     headers: {'Content-Type': 'application/json'},
  //   );

  //   if (res.statusCode == 200) {
  //     final body = jsonDecode(res.body);
  //     myServices.sharedPreferences.setString('access', body['access']);
  //     return true;
  //   }
  //   return false;
  // }
}
