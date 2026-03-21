import 'package:dartz/dartz.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/login_entity.dart';
import 'package:ventro_fnb_app/domain/repositories/repository_domain.dart';

class GetLogin {
  final RepositoryDomain repository;
  GetLogin({required this.repository});

  Future<Either<ErrorEntity, LoginEntity>> call(String login, String password) {
    return repository.login(login, password);
  }
}