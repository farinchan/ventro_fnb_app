

import 'package:equatable/equatable.dart';

class TableEntity extends Equatable {
    final int? id;
    final String? name;
    final String? location;
    final String? status;
    final int? capacity;

    TableEntity({
        this.id,
        this.name,
        this.location,
        this.status,
        this.capacity,
    });
    
      @override
      List<Object?> get props => [id, name, location, status, capacity];

}
