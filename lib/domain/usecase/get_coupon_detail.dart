import 'package:dartz/dartz.dart';
import 'package:ventro_fnb_app/domain/entities/coupon_entity.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/repositories/repository_domain.dart';

class GetCouponDetail {
  final RepositoryDomain repository;
  GetCouponDetail({required this.repository});

  Future<Either<ErrorEntity, CouponEntity>> call(String code) async {
    return await repository.couponDetail(code);
  }
}