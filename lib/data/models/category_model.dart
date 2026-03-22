import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/domain/entities/category_entity.dart';

class CategoryModel extends Equatable {
    final int? id;
    final String? name;
    final String? description;

    CategoryModel({
        this.id,
        this.name,
        this.description,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
    );

    CategoryEntity toEntity() => CategoryEntity(
        id: id,
        name: name,
        description: description,
    );

    @override
    List<Object?> get props => [id, name, description];
}