import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/domain/entities/table_entity.dart';

class TableModel extends Equatable {
  final int? id;
  final String? name;
  final String? location;
  final String? status;
  final int? capacity;

  TableModel({this.id, this.name, this.location, this.status, this.capacity});

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
    id: json["id"],
    name: json["name"],
    location: json["location"],
    status: json["status"],
    capacity: json["capacity"],
  );

  TableEntity toEntity() => TableEntity(
    id: id,
    name: name,
    location: location,
    status: status,
    capacity: capacity,
  );

  @override
  List<Object?> get props => [id, name, location, status, capacity];
}
