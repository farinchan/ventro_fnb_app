import 'package:equatable/equatable.dart';

class TableEntity extends Equatable {
  final String? location;
  final List<TableElementEntity>? tables;

  TableEntity({this.location, this.tables});

  @override
  List<Object?> get props => [location, tables];
}

class TableElementEntity extends Equatable {
  final int? id;
  final String? name;
  final String? status;
  final int? capacity;

  TableElementEntity({this.id, this.name, this.status, this.capacity});

  @override
  List<Object?> get props => [id, name, status, capacity];
}
