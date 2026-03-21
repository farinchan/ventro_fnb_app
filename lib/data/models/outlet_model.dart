import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/domain/entities/outlet_entity.dart';

class OutletModel extends Equatable {
    final String? id;
    final String? name;
    final String? address;
    final String? latitude;
    final String? longitude;
    final String? phone;
    final String? email;
    final Business? business;
    final List<Staff>? staff;

    OutletModel({
        this.id,
        this.name,
        this.address,
        this.latitude,
        this.longitude,
        this.phone,
        this.email,
        this.business,
        this.staff,
    });

    factory OutletModel.fromJson(Map<String, dynamic> json) => OutletModel(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        phone: json["phone"],
        email: json["email"],
        business: json["business"] == null ? null : Business.fromJson(json["business"]),
        staff: json["staff"] == null ? [] : List<Staff>.from(json["staff"]!.map((x) => Staff.fromJson(x))),
    );

    OutletEntity toEntity() => OutletEntity(
        id: id,
        name: name,
        address: address,
        latitude: latitude,
        longitude: longitude,
        phone: phone,
        email: email,
        business: business?.toEntity(),
        staff: staff?.map((s) => s.toEntity()).toList(),
    );

    @override
    List<Object?> get props => [id, name, address, latitude, longitude, phone, email, business, staff];
}

class Business extends Equatable {
    final String? id;
    final String? logo;
    final String? name;
    final String? slug;
    final String? domain;
    final String? description;
    final License? license;
    final String? billingCycle;
    final String? expiryDate;

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
    List<Object?> get props => [id, logo, name, slug, domain, description, license, billingCycle, expiryDate];
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
    List<Object?> get props => [name, description, maxTransactionsPerDay, maxUsers, price];
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
