import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/data/models/category_model.dart';
import 'package:ventro_fnb_app/domain/entities/product_entity.dart';

class ProductModel extends Equatable {
    final int? id;
    final String? image;
    final String? name;
    final String? description;
    final String? status;
    final List<Variant>? variants;
    final CategoryModel? category;
    final Business? business;

    ProductModel({
        this.id,
        this.image,
        this.name,
        this.description,
        this.status,
        this.variants,
        this.category,
        this.business,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        variants: json["variants"] == null ? [] : List<Variant>.from(json["variants"]!.map((x) => Variant.fromJson(x))),
        category: json["category"] == null ? null : CategoryModel.fromJson(json["category"]),
        business: json["business"] == null ? null : Business.fromJson(json["business"]),
    );

    ProductEntity toEntity() => ProductEntity(
        id: id,
        image: image,
        name: name,
        description: description,
        status: status,
        variants: variants?.map((v) => v.toEntity()).toList(),
        category: category?.toEntity(),
        business: business?.toEntity(),
    );

    @override
    List<Object?> get props => [id, image, name, description, status, variants, category, business];
}

class Business extends Equatable {
    final String? id;
    final String? name;
    final String? description;

    Business({
        this.id,
        this.name,
        this.description,
    });

    factory Business.fromJson(Map<String, dynamic> json) => Business(
        id: json["id"],
        name: json["name"],
        description: json["description"],
    );

      BusinessEntity toEntity() => BusinessEntity(
          id: id,
          name: name,
          description: description,
      );

    @override
    List<Object?> get props => [id, name, description];
}



class Variant extends Equatable {
    final int? id;
    final String? name;
    final String? price;

    Variant({
        this.id,
        this.name,
        this.price,
    });

    factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json["id"],
        name: json["name"],
        price: json["price"],
    );

    VariantEntity toEntity() => VariantEntity(
        id: id,
        name: name,
        price: price,
    );

    @override
    List<Object?> get props => [id, name, price];
}
