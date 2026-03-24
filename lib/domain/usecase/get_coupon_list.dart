import 'package:dartz/dartz.dart';
import 'package:ventro_fnb_app/domain/entities/coupon_entity.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/repositories/repository_domain.dart';

class GetCouponList {
  final RepositoryDomain repository;
  GetCouponList({required this.repository});

  Future<Either<ErrorEntity, List<CouponEntity>>> call() async {
    return await repository.couponList();
  }
}