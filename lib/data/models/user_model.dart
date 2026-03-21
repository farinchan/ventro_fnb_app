
import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/data/models/outlet_model.dart';
import 'package:ventro_fnb_app/domain/entities/user_entity.dart';

class UserModel extends Equatable {
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

    UserModel({
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

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        photo: json["photo"],
        username: json["username"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        isActive: json["is_active"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        outlets: json["outlets"] == null ? [] : List<OutletModel>.from(json["outlets"]!.map((x) => OutletModel.fromJson(x))),
    );

    UserEntity toEntity() => UserEntity(
        id: id,
        photo: photo,
        username: username,
        name: name,
        email: email,
        phone: phone,
        role: role,
        isActive: isActive,
        createdAt: createdAt,
        updatedAt: updatedAt,
        outlets: outlets,
    );
    
      @override
      // TODO: implement props
      List<Object?> get props => [id, photo, username, name, email, phone, role, isActive, createdAt, updatedAt, outlets];

}
