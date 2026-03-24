import 'package:equatable/equatable.dart';

class TaxEntity extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? percent;
  final num? value;

  TaxEntity({this.id, this.name, this.description, this.percent, this.value});

  TaxEntity copyWith({
    int? id,
    String? name,
    String? description,
    String? percent,
    num? value,
  }) {
    return TaxEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      percent: percent ?? this.percent,
      value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props => [id, name, description, percent, value];
}
