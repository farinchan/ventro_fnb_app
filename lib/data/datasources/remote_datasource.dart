import 'package:ventro_fnb_app/data/models/login_model.dart';

abstract class RemoteDatasource {
    Future<LoginModel> login(String login, String password);
}