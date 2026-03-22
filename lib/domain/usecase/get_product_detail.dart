import 'package:dartz/dartz.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/product_entity.dart';
import 'package:ventro_fnb_app/domain/repositories/repository_domain.dart';

class GetProductDetail {
  final RepositoryDomain repository;
  GetProductDetail({required this.repository});

  Future<Either<ErrorEntity, ProductEntity>> call(int productId) {
    return repository.productDetail(productId);
  }
}