import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/login_entity.dart';
import 'package:dartz/dartz.dart';

abstract class RepositoryDomain {
    Future<Either<ErrorEntity, LoginEntity>> login(String username, String password);

}