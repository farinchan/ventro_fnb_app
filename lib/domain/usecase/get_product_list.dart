import 'package:dartz/dartz.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/product_entity.dart';
import 'package:ventro_fnb_app/domain/repositories/repository_domain.dart';

class GetProductList {
  final RepositoryDomain repository;
  GetProductList({required this.repository});

  Future<Either<ErrorEntity, List<ProductEntity>>> call() {
    return repository.productList();
  }
}