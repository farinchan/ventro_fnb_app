import 'dart:convert';
import 'dart:developer';

import 'package:ventro_fnb_app/core/network/api_client.dart';
import 'package:ventro_fnb_app/data/datasources/remote_datasource.dart';
import 'package:ventro_fnb_app/data/models/error_model.dart';
import 'package:ventro_fnb_app/data/models/login_model.dart';
import 'package:http/http.dart' as http;

class RemoteDatasourceImpl implements RemoteDatasource {
  final http.Client client;

  RemoteDatasourceImpl({required this.client});

  @override
  Future<LoginModel> login(String login, String password) async {
    try {
      final response = await client.post(
        Uri.parse("${ApiClient.baseUrl}/login"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"login": login, "password": password}),
      );
      final payload = json.decode(response.body)["data"];

      print("Login response: ${payload.toString()}");

      if (response.statusCode == 200) {
        return LoginModel.fromJson(payload);
      } else {
        final error = ErrorModel.fromJson(payload);
        throw error;
      }
    } on ErrorModel {
      rethrow;
    } catch (e) {
      log('Login error: $e', name: 'RemoteDatasourceImpl', error: e);
      throw ErrorModel(status: "error", message: e.toString(), validation: null);
    }
  }
}
