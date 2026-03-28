import 'package:ventro_fnb_app/data/models/category_model.dart';
import 'package:ventro_fnb_app/data/models/coupon_model.dart';
import 'package:ventro_fnb_app/data/models/login_model.dart';
import 'package:ventro_fnb_app/data/models/outlet_model.dart';
import 'package:ventro_fnb_app/data/models/product_mode.dart';
import 'package:ventro_fnb_app/data/models/req/transaction_model.dart';
import 'package:ventro_fnb_app/data/models/sale_mode_model.dart';
import 'package:ventro_fnb_app/data/models/sale_model.dart';
import 'package:ventro_fnb_app/data/models/table_model.dart';
import 'package:ventro_fnb_app/data/models/tax_model.dart';
import 'package:ventro_fnb_app/data/models/user_model.dart';

abstract class RemoteDatasource {
  Future<LoginModel> login(String login, String password);
  Future<UserModel> profile();
  Future<List<OutletModel>> outletList();
  Future<OutletModel> outletDetail();

  Future<List<CategoryModel>> categoryList();
  Future<List<ProductModel>> productList();
  Future<ProductModel> productDetail(int productId);

  Future<List<SaleModeModel>> saleModeList();
  Future<List<TableModel>> tableList();
  Future<List<TaxModel>> taxList();

  Future<List<CouponModel>> couponList();
  Future<CouponModel> couponDetail(String code);

  Future<SaleModel> transaction(TransactionReqModel transactionReqModel);
}
