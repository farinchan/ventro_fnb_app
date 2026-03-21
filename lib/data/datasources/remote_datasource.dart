import 'package:ventro_fnb_app/data/models/login_model.dart';
import 'package:ventro_fnb_app/data/models/outlet_model.dart';

abstract class RemoteDatasource {
    Future<LoginModel> login(String login, String password);
    Future<List<OutletModel>> outletList();
}