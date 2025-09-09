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

  Future<Either<StatusRequest, dynamic>> getData(String linkUrl) async {
    try {
      if (!await checkInternet()) {
        return const Left(StatusRequest.offlineFailure);
      }

      var response = await http.get(
        Uri.parse(linkUrl),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // decode JSON
        var responseBody = jsonDecode(response.body);

        // responseBody can be either a List or Map depending on API
        return Right(responseBody);
      } else {
        print("HTTP ${response.statusCode} ${response.reasonPhrase}");
        print("URL: $linkUrl");
        print("Response raw: ${response.body}");
        return const Left(StatusRequest.serverFailure);
      }
    } catch (e) {
      print("Exception in GET: $e");
      return const Left(StatusRequest.failure);
    }
  }
}
