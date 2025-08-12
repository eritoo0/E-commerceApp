import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/functions/checkinternet.dart';
import 'package:http/http.dart' as http;

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkUrl, Map data) async {
    try {
      // Check Internet Connection
      if (!await checkInternet()) {
        return const Left(StatusRequest.offlineFailure);
      }

      // Send POST request
      var response = await http.post(
        Uri.parse(linkUrl),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json", // Important for Django REST
        },
      );

      // Handle successful response
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var responseBody = jsonDecode(response.body);
        return Right(responseBody);
      }
      print("HTTP ${response.statusCode} ${response.reasonPhrase}");
      print("URL: $linkUrl");
      print("Request body: $data");
      print("Response raw: ${response.body}");

      // Handle error status codes
      return const Left(StatusRequest.serverFailure);
    } catch (e) {
      // Catch any unexpected errors
      return const Left(StatusRequest.failure);
    }
  }
}
