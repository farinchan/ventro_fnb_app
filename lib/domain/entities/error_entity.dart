import 'package:equatable/equatable.dart';

class ErrorEntity extends Equatable {
  final String? status;
  final String? message;
  final List? validation;

  ErrorEntity({this.status, this.message, this.validation});

  @override
  List<Object?> get props => [status, message, validation]; 
}
