import 'package:equatable/equatable.dart';

class TransactionReqModel extends Equatable {
  final int? fnbOutletStaffId;
  final String? customerName;
  final String? customerPhone;
  final int? fnbTableId;
  final int? fnbCouponId;
  final int? fnbSaleModeOutletId;
  final int? paidAmount;
  final String? paymentMethod;
  final List<int>? taxes;
  final List<FnbSaleItem>? fnbSaleItems;

  TransactionReqModel({
    this.fnbOutletStaffId,
    this.customerName,
    this.customerPhone,
    this.fnbTableId,
    this.fnbCouponId,
    this.fnbSaleModeOutletId,
    this.paidAmount,
    this.paymentMethod,
    this.taxes,
    this.fnbSaleItems,
  });

  Map<String, dynamic> toJson() => {
    "fnb_outlet_staff_id": fnbOutletStaffId,
    "customer_name": customerName,
    "customer_phone": customerPhone,
    "fnb_table_id": fnbTableId,
    "fnb_coupon_id": fnbCouponId,
    "fnb_sale_mode_outlet_id": fnbSaleModeOutletId,
    "paid_amount": paidAmount,
    "payment_method": paymentMethod,
    "taxes": taxes == null ? [] : List<dynamic>.from(taxes!.map((x) => x)),
    "fnb_sale_items": fnbSaleItems == null
        ? []
        : List<dynamic>.from(fnbSaleItems!.map((x) => x.toJson())),
  };

  @override
  List<Object?> get props => [
    fnbOutletStaffId,
    customerName,
    customerPhone,
    fnbTableId,
    fnbCouponId,
    fnbSaleModeOutletId,
    paidAmount,
    paymentMethod,
    taxes,
    fnbSaleItems,
  ];
}

class FnbSaleItem extends Equatable {
  final int? fnbProductVariantId;
  final int? quantity;
  final String? note;

  FnbSaleItem({this.fnbProductVariantId, this.quantity, this.note});

  Map<String, dynamic> toJson() => {
    "fnb_product_variant_id": fnbProductVariantId,
    "quantity": quantity,
    "note": note,
  };

  @override
  List<Object?> get props => [fnbProductVariantId, quantity, note];
}
