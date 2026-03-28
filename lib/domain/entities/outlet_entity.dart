import 'package:equatable/equatable.dart';

class OutletEntity extends Equatable {
    final String? id;
    final String? name;
    final String? address;
    final String? latitude;
    final String? longitude;
    final String? phone;
    final String? email;
    final BusinessEntity? business;
    final List<StaffEntity>? staff;

    OutletEntity({
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


    @override
    List<Object?> get props => [id, name, address, latitude, longitude, phone, email, business, staff];
}

class BusinessEntity extends Equatable {
    final String? id;
    final String? logo;
    final String? name;
    final String? slug;
    final String? domain;
    final String? description;
    final LicenseEntity? license;
    final String? billingCycle;
    final String? expiryDate;

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
    List<Object?> get props => [id, logo, name, slug, domain, description, license, billingCycle, expiryDate];
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
    List<Object?> get props => [name, description, maxTransactionsPerDay, maxUsers, price];
}

class StaffEntity extends Equatable {
    final int? id;
    final String? photo;
    final String? name;
    final String? username;
    final String? email;
    final String? phone;
    final int? outletStaffId;

    StaffEntity({
        this.id,
        this.photo,
        this.name,
        this.username,
        this.email,
        this.phone,
        this.outletStaffId,
    });


    @override
    List<Object?> get props => [id, photo, name, username, email, phone, outletStaffId];
  }
