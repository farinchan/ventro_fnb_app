
import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
    final int? id;
    final String? name;
    final String? description;

    CategoryEntity({
        this.id,
        this.name,
        this.description,
    });

    @override
    List<Object?> get props => [id, name, description];
}