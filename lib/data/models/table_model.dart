import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/domain/entities/table_entity.dart';

class TableModel extends Equatable {
  final String? location;
  final List<TableElement>? tables;

  TableModel({this.location, this.tables});

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
    location: json["location"],
    tables: json["tables"] == null
        ? []
        : List<TableElement>.from(
            json["tables"]!.map((x) => TableElement.fromJson(x)),
          ),
  );

  TableEntity toEntity() => TableEntity(
    location: location,
    tables: tables?.map((e) => e.toEntity()).toList(),
  );

  @override
  List<Object?> get props => [location, tables];
}

class TableElement extends Equatable {
  final int? id;
  final String? name;
  final String? status;
  final int? capacity;

  TableElement({this.id, this.name, this.status, this.capacity});

  factory TableElement.fromJson(Map<String, dynamic> json) => TableElement(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    capacity: json["capacity"],
  );

  TableElementEntity toEntity() => TableElementEntity(
    id: id,
    name: name,
    status: status,
    capacity: capacity,
  );

  @override
  List<Object?> get props => [id, name, status, capacity];
}
