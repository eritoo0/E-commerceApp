import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/class/status_request.dart';
import 'package:ecommerce_app/core/functions/checkinternet.dart';
import 'package:http/http.dart' as http;

class Crud {
  Future<Either<StatusRequest, Map>> postDate(String linkUrl, Map data) async {
    try {
      if (await checkInternet()) {
        var respons = await http.post(Uri.parse(linkUrl), body: data);
        if (respons.statusCode == 200 || respons.statusCode == 201) {
          var responseBody = jsonDecode(respons.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverFailure);
    }
  }
}
