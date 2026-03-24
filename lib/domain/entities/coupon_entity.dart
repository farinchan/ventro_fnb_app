import 'package:equatable/equatable.dart';

class CouponEntity extends Equatable {
  final int? id;
  final String? code;
  final String? description;
  final String? type;
  final String? value;
  final int? usageLimit;
  final int? usedCount;
  final DateTime? validFrom;
  final DateTime? validUntil;
  final int? isActive;

  CouponEntity({
    this.id,
    this.code,
    this.description,
    this.type,
    this.value,
    this.usageLimit,
    this.usedCount,
    this.validFrom,
    this.validUntil,
    this.isActive,
  });


  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    code,
    description,
    type,
    value,
    usageLimit,
    usedCount,
    validFrom,
    validUntil,
    isActive,
  ];
}
