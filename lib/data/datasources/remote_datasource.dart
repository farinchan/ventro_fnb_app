import 'package:ventro_fnb_app/data/models/category_model.dart';
import 'package:ventro_fnb_app/data/models/login_model.dart';
import 'package:ventro_fnb_app/data/models/outlet_model.dart';
import 'package:ventro_fnb_app/data/models/product_mode.dart';

abstract class RemoteDatasource {
    Future<LoginModel> login(String login, String password);
    Future<List<OutletModel>> outletList();

    Future<List<CategoryModel>> categoryList();
    Future<List<ProductModel>> productList();
    Future<ProductModel> productDetail(int productId);
}