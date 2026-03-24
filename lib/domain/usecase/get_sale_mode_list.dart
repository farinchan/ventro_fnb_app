import 'package:dartz/dartz.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/sale_mode_entity.dart';
import 'package:ventro_fnb_app/domain/repositories/repository_domain.dart';

class GetSaleModeList {
  final RepositoryDomain repository;
  GetSaleModeList({required this.repository});

  Future<Either<ErrorEntity, List<SaleModeEntity>>> call() async {
    return await repository.saleModeList();
  }
}