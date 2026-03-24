import 'package:dartz/dartz.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/outlet_entity.dart';
import 'package:ventro_fnb_app/domain/repositories/repository_domain.dart';

class GetOutletDetail {
  final RepositoryDomain repository;
  GetOutletDetail({required this.repository});

  Future<Either<ErrorEntity, OutletEntity>> call() async {
    return await repository.outletDetail();
  }
}