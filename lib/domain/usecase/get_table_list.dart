import 'package:dartz/dartz.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/table_entity.dart';
import 'package:ventro_fnb_app/domain/repositories/repository_domain.dart';

class GetTableList {
  final RepositoryDomain repository;
  GetTableList({required this.repository});

  Future<Either<ErrorEntity, List<TableEntity>>> call() async {
    return await repository.tableList();
  }
}
