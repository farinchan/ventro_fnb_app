import 'package:dartz/dartz.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/tax_entity.dart';
import 'package:ventro_fnb_app/domain/repositories/repository_domain.dart';

class GetTaxList {
  final RepositoryDomain repository;
  GetTaxList({required this.repository});

  Future<Either<ErrorEntity, List<TaxEntity>>> call() async {
    return await repository.taxList();
  }
}