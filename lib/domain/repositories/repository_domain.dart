import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/login_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:ventro_fnb_app/domain/entities/outlet_entity.dart';

abstract class RepositoryDomain {
    Future<Either<ErrorEntity, LoginEntity>> login(String username, String password);
    Future<Either<ErrorEntity, List<OutletEntity>>> outletList();
}