import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/domain/entities/category_entity.dart';

class ProductEntity extends Equatable {
    final int? id;
    final String? image;
    final String? name;
    final String? description;
    final String? status;
    final List<VariantEntity>? variants;
    final CategoryEntity? category;
    final BusinessEntity? business;

    ProductEntity({
        this.id,
        this.image,
        this.name,
        this.description,
        this.status,
        this.variants,
        this.category,
        this.business,
    });

    @override
    List<Object?> get props => [id, image, name, description, status, variants, category, business];
}

class BusinessEntity extends Equatable {
    final String? id;
    final String? name;
    final String? description;

    BusinessEntity({
        this.id,
        this.name,
        this.description,
    });
    @override
    List<Object?> get props => [id, name, description];
}

class VariantEntity extends Equatable {
    final int? id;
    final String? name;
    final String? price;

    VariantEntity({
        this.id,
        this.name,
        this.price,
    });

    @override
    List<Object?> get props => [id, name, price];
}
