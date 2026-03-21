import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';

class ErrorModel extends Equatable {
  final String? status;
  final String? message;
  final List? validation;

  ErrorModel({this.status, this.message, this.validation});

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      ErrorModel(status: json["status"], message: json["message"], validation: json["validation"]);

  ErrorEntity toEntity() => ErrorEntity(status: status, message: message, validation: validation);

  @override
  List<Object?> get props => [status, message, validation];
}
