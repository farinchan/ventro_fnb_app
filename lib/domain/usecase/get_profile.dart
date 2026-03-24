import 'package:dartz/dartz.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/user_entity.dart';
import 'package:ventro_fnb_app/domain/repositories/repository_domain.dart';

class GetProfile {
  final RepositoryDomain repository;
  GetProfile({required this.repository});

  Future<Either<ErrorEntity, UserEntity>> call() {
    return repository.profile();
  }
}