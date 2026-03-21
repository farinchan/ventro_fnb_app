import 'dart:convert';

import 'package:http/http.dart';
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
      if (response.statusCode == 200) {
        return LoginModel.fromJson(json.decode(response.body));
      } else {
        final error = ErrorModel.fromJson(json.decode(response.body));
        throw error;
        
      }
    } catch (e) {
      throw ErrorModel(status: "error", message: e.toString(), validation: null);
    }
  }
}
