import 'package:ventro_fnb_app/domain/entities/category_entity.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/login_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:ventro_fnb_app/domain/entities/outlet_entity.dart';
import 'package:ventro_fnb_app/domain/entities/product_entity.dart';
import 'package:ventro_fnb_app/domain/entities/user_entity.dart';

abstract class RepositoryDomain {
    Future<Either<ErrorEntity, LoginEntity>> login(String username, String password);
    Future<Either<ErrorEntity, UserEntity>> profile();
    Future<Either<ErrorEntity, List<OutletEntity>>> outletList();
    Future<Either<ErrorEntity, OutletEntity>> outletDetail();

    Future<Either<ErrorEntity, List<CategoryEntity>>> categoryList();
    Future<Either<ErrorEntity, List<ProductEntity>>> productList();
    Future<Either<ErrorEntity, ProductEntity>> productDetail(int productId);
}