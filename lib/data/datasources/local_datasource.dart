import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';


class LocalDatasource {
  static const String tokenKey = "auth_token";
  static const String outletIdKey = "outlet_id";
  static const String staffOutletIdKey = "staff_outlet_id";

  Future<void> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(tokenKey, token);
    log("Token saved: $token", name: 'LocalDatasourceImpl');
  }

  Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString(tokenKey);
    log("Token retrieved: $token", name: 'LocalDatasourceImpl');
    return token;
  }

  Future<void> removeToken() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(tokenKey);
    log("Token removed", name: 'LocalDatasourceImpl');
  }

  Future<void> saveOutletId(String outletId) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(outletIdKey, outletId);
    log("Outlet ID saved: $outletId", name: 'LocalDatasourceImpl');
  }

  Future<String?> getOutletId() async {
    final pref = await SharedPreferences.getInstance();
    final outletId = pref.getString(outletIdKey);
    log("Outlet ID retrieved: $outletId", name: 'LocalDatasourceImpl');
    return outletId;
  }

  Future<void> removeOutletId() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(outletIdKey);
    log("Outlet ID removed", name: 'LocalDatasourceImpl');
  } 

  Future<void> saveStaffOutletId(int staffOutletId) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt(staffOutletIdKey, staffOutletId);
    log("Staff Outlet ID saved: $staffOutletId", name: 'LocalDatasourceImpl');
  }

  Future<int?> getStaffOutletId() async {
    final pref = await SharedPreferences.getInstance();
    final staffOutletId = pref.getInt(staffOutletIdKey);
    log("Staff Outlet ID retrieved: $staffOutletId", name: 'LocalDatasourceImpl');
    return staffOutletId;
  }

  Future<void> removeStaffOutletId() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(staffOutletIdKey);
    log("Staff Outlet ID removed", name: 'LocalDatasourceImpl');
  } 

}
