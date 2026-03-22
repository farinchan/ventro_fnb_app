import 'dart:convert';
import 'dart:developer';

import 'package:ventro_fnb_app/core/network/api_client.dart';
import 'package:ventro_fnb_app/data/datasources/local_datasource.dart';
import 'package:ventro_fnb_app/data/datasources/remote_datasource.dart';
import 'package:ventro_fnb_app/data/models/category_model.dart';
import 'package:ventro_fnb_app/data/models/error_model.dart';
import 'package:ventro_fnb_app/data/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:ventro_fnb_app/data/models/outlet_model.dart';
import 'package:ventro_fnb_app/data/models/product_mode.dart';

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

  @override
  Future<List<OutletModel>> outletList() async {
    try {
      var token = await LocalDatasource().getToken();
      final response = await client.get(
        Uri.parse("${ApiClient.baseUrl}/outlets-list"),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
      );

      final payload = json.decode(response.body)["data"];

      if (response.statusCode == 200) {
        return (payload as List).map((e) => OutletModel.fromJson(e)).toList();
      } else {
        final error = ErrorModel.fromJson(payload);
        throw error;
      }
    } on ErrorModel {
      rethrow;
    } catch (e) {
      log('Outlet list error: $e', name: 'RemoteDatasourceImpl', error: e);
      throw ErrorModel(status: "error", message: e.toString(), validation: null);
    }
  }

  @override
  Future<List<CategoryModel>> categoryList() async {
    try {
      var token = await LocalDatasource().getToken();
      var outletId = await LocalDatasource().getOutletId();
      final response = await client.get(
        Uri.parse("${ApiClient.baseUrl}/categories"),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $token", "X-Outlet-ID": "$outletId"},
      );

      final payload = json.decode(response.body)["data"];

      if (response.statusCode == 200) {
        return (payload as List).map((e) => CategoryModel.fromJson(e)).toList();
      } else {
        final error = ErrorModel.fromJson(payload);
        throw error;
      }
    } on ErrorModel {
      rethrow;
    } catch (e) {
      log('Category list error: $e', name: 'RemoteDatasourceImpl', error: e);
      throw ErrorModel(status: "error", message: e.toString(), validation: null);
    }
  }

  @override
  Future<List<ProductModel>> productList() async {
    try {
      var token = await LocalDatasource().getToken();
      var outletId = await LocalDatasource().getOutletId();
      final response = await client.get(
        Uri.parse("${ApiClient.baseUrl}/products"),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $token", "X-Outlet-ID": "$outletId"},
      );

      final payload = json.decode(response.body)["data"];

      if (response.statusCode == 200) {
        return (payload as List).map((e) => ProductModel.fromJson(e)).toList();
      } else {
        final error = ErrorModel.fromJson(payload);
        throw error;
      }
    } on ErrorModel {
      rethrow;
    } catch (e) {
      log('Product list error: $e', name: 'RemoteDatasourceImpl', error: e);
      throw ErrorModel(status: "error", message: e.toString(), validation: null);
    }
  }

  @override
  Future<ProductModel> productDetail(int productId) async {
    try {
      var token = await LocalDatasource().getToken();
      final response = await client.get(
        Uri.parse("${ApiClient.baseUrl}/products/$productId"),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
      );

      final payload = json.decode(response.body)["data"];

      if (response.statusCode == 200) {
        return ProductModel.fromJson(payload);
      } else {
        final error = ErrorModel.fromJson(payload);
        throw error;
      }
    } on ErrorModel {
      rethrow;
    } catch (e) {
      log('Product detail error: $e', name: 'RemoteDatasourceImpl', error: e);
      throw ErrorModel(status: "error", message: e.toString(), validation: null);
    }
  }

  
}
