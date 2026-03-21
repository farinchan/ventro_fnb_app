import 'package:dartz/dartz.dart';
import 'package:ventro_fnb_app/data/datasources/remote_datasource.dart';
import 'package:ventro_fnb_app/data/models/error_model.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/login_entity.dart';
import 'package:ventro_fnb_app/domain/repositories/repository_domain.dart';

class RepositoryDomainImpl implements RepositoryDomain {
  final RemoteDatasource remoteDatasource;
  RepositoryDomainImpl({required this.remoteDatasource});

  @override
  Future<Either<ErrorEntity, LoginEntity>> login(String username, String password) async {
    try {
      final result = await remoteDatasource.login(username, password);
      print('Login successful: ${result.toEntity()}');
      return Right(result.toEntity());
    } on ErrorModel catch (e) {
      return Left(e.toEntity());
    } catch (e) {
      return Left(ErrorEntity(status: "error", message: e.toString(), validation: null));
    }
  }
}
