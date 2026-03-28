import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/domain/entities/coupon_entity.dart';
import 'package:ventro_fnb_app/domain/entities/outlet_entity.dart';
import 'package:ventro_fnb_app/domain/entities/user_entity.dart';

class SaleEntity extends Equatable {
  final String? id;
  final String? invoiceNumber;
  final OutletEntity? outlet;
  final UserEntity? outletStaff;
  final CostumerEntity? costumer;
  final TableEntity? table;
  final CouponEntity? coupon;
  final SaleModeEntity? saleMode;
  final List<ItemEntity>? items;
  final String? subtotal;
  final String? discount;
  final List<TaxEntity>? taxes;
  final int? taxAmount;
  final String? total;
  final String? paidAmount;
  final String? changeAmount;
  final String? paymentMethod;
  final String? status;
  final dynamic midtransTransactionId;
  final QrisEntity? qris;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SaleEntity({
    this.id,
    this.invoiceNumber,
    this.outlet,
    this.outletStaff,
    this.costumer,
    this.table,
    this.coupon,
    this.saleMode,
    this.items,
    this.subtotal,
    this.discount,
    this.taxes,
    this.taxAmount,
    this.total,
    this.paidAmount,
    this.changeAmount,
    this.paymentMethod,
    this.status,
    this.midtransTransactionId,
    this.qris,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    invoiceNumber,
    outlet,
    outletStaff,
    costumer,
    table,
    coupon,
    saleMode,
    items,
    subtotal,
    discount,
    taxes,
    taxAmount,
    total,
    paidAmount,
    changeAmount,
    paymentMethod,
    status,
    midtransTransactionId,
    qris,
    createdAt,
    updatedAt,
  ];
}

class CostumerEntity extends Equatable {
  final int? id;
  final String? name;
  final dynamic phone;
  final dynamic email;

  CostumerEntity({this.id, this.name, this.phone, this.email});

  @override
  List<Object?> get props => [id, name, phone, email];
}

class ItemEntity extends Equatable {
  final int? id;
  final int? fnbProductVariantId;
  final ProductEntity? product;
  final String? unitPrice;
  final int? quantity;
  final String? totalPrice;
  final String? note;

  ItemEntity({
    this.id,
    this.fnbProductVariantId,
    this.product,
    this.unitPrice,
    this.quantity,
    this.totalPrice,
    this.note,
  });

  @override
  List<Object?> get props => [
    id,
    fnbProductVariantId,
    product,
    unitPrice,
    quantity,
    totalPrice,
    note,
  ];
}

class ProductEntity extends Equatable {
  final int? id;
  final String? name;
  final String? price;
  final String? productName;
  final String? productImage;

  ProductEntity({
    this.id,
    this.name,
    this.price,
    this.productName,
    this.productImage,
  });

  @override
  List<Object?> get props => [id, name, price, productName, productImage];
}

class BusinessEntity extends Equatable {
  final String? id;
  final String? logo;
  final String? name;
  final String? slug;
  final String? domain;
  final String? description;
  final LicenseEntity? license;
  final dynamic billingCycle;
  final dynamic expiryDate;

  BusinessEntity({
    this.id,
    this.logo,
    this.name,
    this.slug,
    this.domain,
    this.description,
    this.license,
    this.billingCycle,
    this.expiryDate,
  });

  @override
  List<Object?> get props => [
    id,
    logo,
    name,
    slug,
    domain,
    description,
    license,
    billingCycle,
    expiryDate,
  ];
}

class LicenseEntity extends Equatable {
  final String? name;
  final String? description;
  final int? maxTransactionsPerDay;
  final int? maxUsers;
  final String? price;

  LicenseEntity({
    this.name,
    this.description,
    this.maxTransactionsPerDay,
    this.maxUsers,
    this.price,
  });

  @override
  List<Object?> get props => [
    name,
    description,
    maxTransactionsPerDay,
    maxUsers,
    price,
  ];
}

class StaffEntity extends Equatable {
  final int? id;
  final String? photo;
  final String? name;
  final String? username;
  final String? email;
  final String? phone;

  StaffEntity({
    this.id,
    this.photo,
    this.name,
    this.username,
    this.email,
    this.phone,
  });

  @override
  List<Object?> get props => [id, photo, name, username, email, phone];
}

class QrisEntity extends Equatable {
  final String? name;
  final String? method;
  final String? url;

  QrisEntity({this.name, this.method, this.url});

  @override
  List<Object?> get props => [name, method, url];
}

class SaleModeEntity extends Equatable {
  final int? id;
  final String? name;

  SaleModeEntity({this.id, this.name});

  @override
  List<Object?> get props => [id, name];
}

class TableEntity extends Equatable {
  final int? id;
  final String? name;
  final String? location;
  final int? capacity;

  TableEntity({this.id, this.name, this.location, this.capacity});

  @override
  List<Object?> get props => [id, name, location, capacity];
}

class TaxEntity extends Equatable {
  final String? name;
  final String? percent;
  final int? amount;

  TaxEntity({this.name, this.percent, this.amount});

  @override
  List<Object?> get props => [name, percent, amount];
}
