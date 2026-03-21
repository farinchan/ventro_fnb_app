
import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/data/models/outlet_model.dart';

class UserEntity extends Equatable {
    final int? id;
    final String? photo;
    final String? username;
    final String? name;
    final String? email;
    final String? phone;
    final String? role;
    final String? isActive;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final List<OutletModel>? outlets;

    UserEntity({
        this.id,
        this.photo,
        this.username,
        this.name,
        this.email,
        this.phone,
        this.role,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.outlets,
    });
    
      @override
      // TODO: implement props
      List<Object?> get props => [id, photo, username, name, email, phone, role, isActive, createdAt, updatedAt, outlets];


}
