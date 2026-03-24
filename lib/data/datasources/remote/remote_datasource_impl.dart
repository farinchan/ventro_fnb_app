import 'dart:convert';
import 'dart:developer';

import 'package:ventro_fnb_app/core/network/api_client.dart';
import 'package:ventro_fnb_app/data/datasources/local_datasource.dart';
import 'package:ventro_fnb_app/data/datasources/remote_datasource.dart';
import 'package:ventro_fnb_app/data/models/category_model.dart';
import 'package:ventro_fnb_app/data/models/coupon_model.dart';
import 'package:ventro_fnb_app/data/models/error_model.dart';
import 'package:ventro_fnb_app/data/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:ventro_fnb_app/data/models/outlet_model.dart';
import 'package:ventro_fnb_app/data/models/product_mode.dart';
import 'package:ventro_fnb_app/data/models/sale_mode_model.dart';
import 'package:ventro_fnb_app/data/models/table_model.dart';
import 'package:ventro_fnb_app/data/models/tax_model.dart';
import 'package:ventro_fnb_app/data/models/user_model.dart';

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
      throw ErrorModel(
        status: "error",
        message: e.toString(),
        validation: null,
      );
    }
  }

  @override
  Future<UserModel> profile() async {
    try {
      var token = await LocalDatasource().getToken();
      var outletId = await LocalDatasource().getOutletId();
      final response = await client.get(
        Uri.parse("${ApiClient.baseUrl}/profile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "X-Outlet-ID": "$outletId",
        },
      );

      final payload = json.decode(response.body)["data"];

      if (response.statusCode == 200) {
        return UserModel.fromJson(payload);
      } else {
        final error = ErrorModel.fromJson(payload);
        throw error;
      }
    } on ErrorModel {
      rethrow;
    } catch (e) {
      log('Profile error: $e', name: 'RemoteDatasourceImpl', error: e);
      throw ErrorModel(
        status: "error",
        message: e.toString(),
        validation: null,
      );
    }
  }

  @override
  Future<List<OutletModel>> outletList() async {
    try {
      var token = await LocalDatasource().getToken();
      final response = await client.get(
        Uri.parse("${ApiClient.baseUrl}/outlets-list"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
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
      throw ErrorModel(
        status: "error",
        message: e.toString(),
        validation: null,
      );
    }
  }

  @override
  Future<OutletModel> outletDetail() async {
    try {
      var token = await LocalDatasource().getToken();
      var outletId = await LocalDatasource().getOutletId();
      final response = await client.get(
        Uri.parse("${ApiClient.baseUrl}/outlet"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "X-Outlet-ID": "$outletId",
        },
      );

      final payload = json.decode(response.body)["data"];

      if (response.statusCode == 200) {
        return OutletModel.fromJson(payload);
      } else {
        final error = ErrorModel.fromJson(payload);
        throw error;
      }
    } on ErrorModel {
      rethrow;
    } catch (e) {
      log('Outlet detail error: $e', name: 'RemoteDatasourceImpl', error: e);
      throw ErrorModel(
        status: "error",
        message: e.toString(),
        validation: null,
      );
    }
  }

  @override
  Future<List<CategoryModel>> categoryList() async {
    try {
      var token = await LocalDatasource().getToken();
      var outletId = await LocalDatasource().getOutletId();
      final response = await client.get(
        Uri.parse("${ApiClient.baseUrl}/categories"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "X-Outlet-ID": "$outletId",
        },
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
      throw ErrorModel(
        status: "error",
        message: e.toString(),
        validation: null,
      );
    }
  }

  @override
  Future<List<ProductModel>> productList() async {
    try {
      var token = await LocalDatasource().getToken();
      var outletId = await LocalDatasource().getOutletId();
      final response = await client.get(
        Uri.parse("${ApiClient.baseUrl}/products"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "X-Outlet-ID": "$outletId",
        },
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
      throw ErrorModel(
        status: "error",
        message: e.toString(),
        validation: null,
      );
    }
  }

  @override
  Future<ProductModel> productDetail(int productId) async {
    try {
      var token = await LocalDatasource().getToken();
      final response = await client.get(
        Uri.parse("${ApiClient.baseUrl}/products/$productId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
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
      throw ErrorModel(
        status: "error",
        message: e.toString(),
        validation: null,
      );
    }
  }

  //TODO: UTILITIES - Sale Mode
  @override
  Future<List<SaleModeModel>> saleModeList() async {
    try {
      var token = await LocalDatasource().getToken();
      var outletId = await LocalDatasource().getOutletId();
      final response = await client.get(
        Uri.parse("${ApiClient.baseUrl}/utilities/sale-mode"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "X-Outlet-ID": "$outletId",
        },
      );

      final payload = json.decode(response.body)["data"];

      if (response.statusCode == 200) {
        return (payload as List).map((e) => SaleModeModel.fromJson(e)).toList();
      } else {
        final error = ErrorModel.fromJson(payload);
        throw error;
      }
    } on ErrorModel {
      rethrow;
    } catch (e) {
      log('Sale mode list error: $e', name: 'RemoteDatasourceImpl', error: e);
      throw ErrorModel(
        status: "error",
        message: e.toString(),
        validation: null,
      );
    }
  }

  //TODO: UTILITIES - Table
  @override
  Future<List<TableModel>> tableList() async {
    try {
      var token = await LocalDatasource().getToken();
      var outletId = await LocalDatasource().getOutletId();
      final response = await client.get(
        Uri.parse("${ApiClient.baseUrl}/utilities/table"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "X-Outlet-ID": "$outletId",
        },
      );

      final payload = json.decode(response.body)["data"];

      if (response.statusCode == 200) {
        return (payload as List).map((e) => TableModel.fromJson(e)).toList();
      } else {
        final error = ErrorModel.fromJson(payload);
        throw error;
      }
    } on ErrorModel {
      rethrow;
    } catch (e) {
      log('Table list error: $e', name: 'RemoteDatasourceImpl', error: e);
      throw ErrorModel(
        status: "error",
        message: e.toString(),
        validation: null,
      );
    }
  }

  @override
  Future<List<TaxModel>> taxList() async {
    try {
      var token = await LocalDatasource().getToken();
      var outletId = await LocalDatasource().getOutletId();
      final response = await client.get(
        Uri.parse("${ApiClient.baseUrl}/utilities/tax"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "X-Outlet-ID": "$outletId",
        },
      );

      final payload = json.decode(response.body)["data"];

      if (response.statusCode == 200) {
        return (payload as List).map((e) => TaxModel.fromJson(e)).toList();
      } else {
        final error = ErrorModel.fromJson(payload);
        throw error;
      }
    } on ErrorModel {
      rethrow;
    } catch (e) {
      log('Tax list error: $e', name: 'RemoteDatasourceImpl', error: e);
      throw ErrorModel(
        status: "error",
        message: e.toString(),
        validation: null,
      );
    }
  }

  @override
  Future<List<CouponModel>> couponList() async {
    try {
      var token = await LocalDatasource().getToken();
      var outletId = await LocalDatasource().getOutletId();
      final response = await client.get(
        Uri.parse("${ApiClient.baseUrl}/coupons"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "X-Outlet-ID": "$outletId",
        },
      );

      if (response.statusCode == 200) {
        final payload = json.decode(response.body)["data"];
        return (payload as List).map((e) => CouponModel.fromJson(e)).toList();
      } else {
        final error = ErrorModel.fromJson(json.decode(response.body));
        throw error;
      }
    } on ErrorModel {
      rethrow;
    } catch (e) {
      log('Coupon list error: $e', name: 'RemoteDatasourceImpl', error: e);
      throw ErrorModel(
        status: "error",
        message: e.toString(),
        validation: null,
      );
    }
  }

  @override
  Future<CouponModel> couponDetail(String code) async {
    try {
      var token = await LocalDatasource().getToken();
      var outletId = await LocalDatasource().getOutletId();
      final response = await client.get(
        Uri.parse("${ApiClient.baseUrl}/coupons/$code"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "X-Outlet-ID": "$outletId",
        },
      );

      if (response.statusCode == 200) {
        return CouponModel.fromJson(json.decode(response.body)["data"]);
      } else {
        final error = ErrorModel.fromJson(json.decode(response.body));
        throw error;
      }
    } on ErrorModel {
      rethrow;
    } catch (e) {
      log('Coupon detail error: $e', name: 'RemoteDatasourceImpl', error: e);
      throw ErrorModel(
        status: "error",
        message: e.toString(),
        validation: null,
      );
    }
  }
}
