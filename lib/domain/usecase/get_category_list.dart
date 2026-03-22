import 'package:dartz/dartz.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/category_entity.dart';
import 'package:ventro_fnb_app/domain/repositories/repository_domain.dart';

class GetCategoryList {
  final RepositoryDomain repository;
  GetCategoryList({required this.repository});

  Future<Either<ErrorEntity, List<CategoryEntity>>> call() {
    return repository.categoryList();
  }
}