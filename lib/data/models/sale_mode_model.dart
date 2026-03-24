import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/domain/entities/sale_mode_entity.dart';

class SaleModeModel extends Equatable {
  final int? id;
  final String? name;
  final String? description;

  SaleModeModel({this.id, this.name, this.description});

  factory SaleModeModel.fromJson(Map<String, dynamic> json) => SaleModeModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
  );

  SaleModeEntity toEntity() =>
      SaleModeEntity(id: id, name: name, description: description);

  @override
  List<Object?> get props => [id, name, description];
}
