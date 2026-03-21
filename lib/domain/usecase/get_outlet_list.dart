import 'package:dartz/dartz.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/login_entity.dart';
import 'package:ventro_fnb_app/domain/entities/outlet_entity.dart';
import 'package:ventro_fnb_app/domain/repositories/repository_domain.dart';

class GetOutletList {
  final RepositoryDomain repository;
  GetOutletList({required this.repository});

  Future<Either<ErrorEntity, List<OutletEntity>>> call() {
    return repository.outletList();
  }
}