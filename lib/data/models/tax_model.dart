import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/domain/entities/tax_entity.dart';

class TaxModel extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? percent;

  TaxModel({this.id, this.name, this.description, this.percent});

  factory TaxModel.fromJson(Map<String, dynamic> json) => TaxModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    percent: json["percent"],
  );

  TaxEntity toEntity() =>
      TaxEntity(id: id, name: name, description: description, percent: percent);

  @override
  List<Object?> get props => [id, name, description, percent];
}
