import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/domain/entities/coupon_entity.dart';

class CouponModel extends Equatable {
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

  CouponModel({
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

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
    id: json["id"],
    code: json["code"],
    description: json["description"],
    type: json["type"],
    value: json["value"],
    usageLimit: json["usage_limit"],
    usedCount: json["used_count"],
    validFrom: json["valid_from"] == null
        ? null
        : DateTime.parse(json["valid_from"]),
    validUntil: json["valid_until"] == null
        ? null
        : DateTime.parse(json["valid_until"]),
    isActive: json["is_active"],
  );

  CouponEntity toEntity() => CouponEntity(
    id: id,
    code: code,
    description: description,
    type: type,
    value: value,
    usageLimit: usageLimit,
    usedCount: usedCount,
    validFrom: validFrom,
    validUntil: validUntil,
    isActive: isActive,
  );

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
