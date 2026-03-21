import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/data/models/user_model.dart';
import 'package:ventro_fnb_app/domain/entities/login_entity.dart';

class LoginModel extends Equatable {
  final UserModel? user;
  final String? token;

  LoginModel({this.user, this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      LoginModel(user: UserModel.fromJson(json["user"]), token: json["token"]);

  LoginEntity toEntity() => LoginEntity(user: user!.toEntity(), token: token!);

  @override
  List<Object?> get props => [user, token];
}
