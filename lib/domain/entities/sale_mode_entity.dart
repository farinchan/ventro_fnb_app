

import 'package:equatable/equatable.dart';

class SaleModeEntity extends Equatable {
    final int? id;
    final String? name;
    final String? description;

    SaleModeEntity({
        this.id,
        this.name,
        this.description,
    });
    
      @override
      List<Object?> get props => [id, name, description];
}
