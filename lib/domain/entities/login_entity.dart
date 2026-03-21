import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/data/models/user_model.dart';

class LoginEntity extends Equatable{
  final UserModel user;
  final String token;

  LoginEntity({
    required this.user,
    required this.token,
  });

  @override
  List<Object?> get props => [user, token];

}