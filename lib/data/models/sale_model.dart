import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/data/models/coupon_model.dart';
import 'package:ventro_fnb_app/data/models/outlet_model.dart';
import 'package:ventro_fnb_app/data/models/user_model.dart';
import 'package:ventro_fnb_app/domain/entities/sale_entity.dart';

class SaleModel extends Equatable {
  final String? id;
  final String? invoiceNumber;
  final OutletModel? outlet;
  final UserModel? outletStaff;
  final Costumer? costumer;
  final Table? table;
  final CouponModel? coupon;
  final SaleMode? saleMode;
  final List<Item>? items;
  final String? subtotal;
  final String? discount;
  final List<Tax>? taxes;
  final int? taxAmount;
  final String? total;
  final String? paidAmount;
  final String? changeAmount;
  final String? paymentMethod;
  final String? status;
  final dynamic midtransTransactionId;
  final Qris? qris;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SaleModel({
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

  factory SaleModel.fromJson(Map<String, dynamic> json) => SaleModel(
    id: json["id"],
    invoiceNumber: json["invoice_number"],
    outlet: json["outlet"] == null
        ? null
        : OutletModel.fromJson(json["outlet"]),
    outletStaff: json["outlet_staff"] == null
        ? null
        : UserModel.fromJson(json["outlet_staff"]),
    costumer: json["costumer"] == null
        ? null
        : Costumer.fromJson(json["costumer"]),
    table: json["table"] == null ? null : Table.fromJson(json["table"]),
    coupon: json["coupon"] == null
        ? null
        : CouponModel.fromJson(json["coupon"]),
    saleMode: json["sale_mode"] == null
        ? null
        : SaleMode.fromJson(json["sale_mode"]),
    items: json["items"] == null
        ? []
        : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    subtotal: json["subtotal"],
    discount: json["discount"],
    taxes: json["taxes"] == null
        ? []
        : List<Tax>.from(json["taxes"]!.map((x) => Tax.fromJson(x))),
    taxAmount: json["tax_amount"],
    total: json["total"],
    paidAmount: json["paid_amount"],
    changeAmount: json["change_amount"],
    paymentMethod: json["payment_method"],
    status: json["status"],
    midtransTransactionId: json["midtrans_transaction_id"],
    qris: json["qris"] == null ? null : Qris.fromJson(json["qris"]),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  SaleEntity toEntity() => SaleEntity(
    id: id,
    invoiceNumber: invoiceNumber,
    outlet: outlet?.toEntity(),
    outletStaff: outletStaff?.toEntity(),
    costumer: costumer?.toEntity(),
    table: table?.toEntity(),
    coupon: coupon?.toEntity(),
    saleMode: saleMode?.toEntity(),
    items: items?.map((e) => e.toEntity()).toList(),
    subtotal: subtotal,
    discount: discount,
    taxes: taxes?.map((e) => e.toEntity()).toList(),
    taxAmount: taxAmount,
    total: total,
    paidAmount: paidAmount,
    changeAmount: changeAmount,
    paymentMethod: paymentMethod,
    status: status,
    midtransTransactionId: midtransTransactionId,
    qris: qris?.toEntity(),
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

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

class Costumer extends Equatable {
  final int? id;
  final String? name;
  final dynamic phone;
  final dynamic email;

  Costumer({this.id, this.name, this.phone, this.email});

  factory Costumer.fromJson(Map<String, dynamic> json) => Costumer(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
  );

  CostumerEntity toEntity() => CostumerEntity(
    id: id,
    name: name,
    phone: phone,
    email: email,
  );

  @override
  List<Object?> get props => [id, name, phone, email];
}

class Item extends Equatable {
  final int? id;
  final int? fnbProductVariantId;
  final Product? product;
  final String? unitPrice;
  final int? quantity;
  final String? totalPrice;
  final String? note;

  Item({
    this.id,
    this.fnbProductVariantId,
    this.product,
    this.unitPrice,
    this.quantity,
    this.totalPrice,
    this.note,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    fnbProductVariantId: json["fnb_product_variant_id"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    unitPrice: json["unit_price"],
    quantity: json["quantity"],
    totalPrice: json["total_price"],
    note: json["note"],
  );

  ItemEntity toEntity() => ItemEntity(
    id: id,
    fnbProductVariantId: fnbProductVariantId,
    product: product?.toEntity(),
    unitPrice: unitPrice,
    quantity: quantity,
    totalPrice: totalPrice,
    note: note,
  );

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

class Product extends Equatable {
  final int? id;
  final String? name;
  final String? price;
  final String? productName;
  final String? productImage;

  Product({
    this.id,
    this.name,
    this.price,
    this.productName,
    this.productImage,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    productName: json["product_name"],
    productImage: json["product_image"],
  );

  ProductEntity toEntity() => ProductEntity(
    id: id,
    name: name,
    price: price,
    productName: productName,
    productImage: productImage,
  );

  @override
  List<Object?> get props => [id, name, price, productName, productImage];
}

class Business extends Equatable {
  final String? id;
  final String? logo;
  final String? name;
  final String? slug;
  final String? domain;
  final String? description;
  final License? license;
  final dynamic billingCycle;
  final dynamic expiryDate;

  Business({
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

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    id: json["id"],
    logo: json["logo"],
    name: json["name"],
    slug: json["slug"],
    domain: json["domain"],
    description: json["description"],
    license: json["license"] == null ? null : License.fromJson(json["license"]),
    billingCycle: json["billing_cycle"],
    expiryDate: json["expiry_date"],
  );

  BusinessEntity toEntity() => BusinessEntity(
    id: id,
    logo: logo,
    name: name,
    slug: slug,
    domain: domain,
    description: description,
    license: license?.toEntity(),
    billingCycle: billingCycle,
    expiryDate: expiryDate,
  );

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

class License extends Equatable {
  final String? name;
  final String? description;
  final int? maxTransactionsPerDay;
  final int? maxUsers;
  final String? price;

  License({
    this.name,
    this.description,
    this.maxTransactionsPerDay,
    this.maxUsers,
    this.price,
  });

  factory License.fromJson(Map<String, dynamic> json) => License(
    name: json["name"],
    description: json["description"],
    maxTransactionsPerDay: json["max_transactions_per_day"],
    maxUsers: json["max_users"],
    price: json["price"],
  );

  LicenseEntity toEntity() => LicenseEntity(
    name: name,
    description: description,
    maxTransactionsPerDay: maxTransactionsPerDay,
    maxUsers: maxUsers,
    price: price,
  );

  @override
  List<Object?> get props => [
    name,
    description,
    maxTransactionsPerDay,
    maxUsers,
    price,
  ];
}

class Staff extends Equatable {
  final int? id;
  final String? photo;
  final String? name;
  final String? username;
  final String? email;
  final String? phone;

  Staff({
    this.id,
    this.photo,
    this.name,
    this.username,
    this.email,
    this.phone,
  });

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
    id: json["id"],
    photo: json["photo"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    phone: json["phone"],
  );

  StaffEntity toEntity() => StaffEntity(
    id: id,
    photo: photo,
    name: name,
    username: username,
    email: email,
    phone: phone,
  );

  @override
  List<Object?> get props => [id, photo, name, username, email, phone];
}

class Qris extends Equatable {
  final String? name;
  final String? method;
  final String? url;

  Qris({this.name, this.method, this.url});

  factory Qris.fromJson(Map<String, dynamic> json) =>
      Qris(name: json["name"], method: json["method"], url: json["url"]);

  QrisEntity toEntity() => QrisEntity(
    name: name,
    method: method,
    url: url,
  );

  @override
  List<Object?> get props => [name, method, url];
}

class SaleMode extends Equatable {
  final int? id;
  final String? name;

  SaleMode({this.id, this.name});

  factory SaleMode.fromJson(Map<String, dynamic> json) =>
      SaleMode(id: json["id"], name: json["name"]);

  SaleModeEntity toEntity() => SaleModeEntity(
    id: id,
    name: name,
  );

  @override
  List<Object?> get props => [id, name];
}

class Table extends Equatable {
  final int? id;
  final String? name;
  final String? location;
  final int? capacity;

  Table({this.id, this.name, this.location, this.capacity});

  factory Table.fromJson(Map<String, dynamic> json) => Table(
    id: json["id"],
    name: json["name"],
    location: json["location"],
    capacity: json["capacity"],
  );

  TableEntity toEntity() => TableEntity(
    id: id,
    name: name,
    location: location,
    capacity: capacity,
  );

  @override
  List<Object?> get props => [id, name, location, capacity];
}

class Tax extends Equatable {
  final String? name;
  final String? percent;
  final int? amount;

  Tax({this.name, this.percent, this.amount});

  factory Tax.fromJson(Map<String, dynamic> json) =>
      Tax(name: json["name"], percent: json["percent"], amount: json["amount"]);

  TaxEntity toEntity() => TaxEntity(
    name: name,
    percent: percent,
    amount: amount,
  );

  @override
  List<Object?> get props => [name, percent, amount];
}
