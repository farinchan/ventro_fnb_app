part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final UserEntity? user;
  final OutletEntity? outlet;
  const ProfileLoaded({this.user, this.outlet});

  @override
  List<Object> get props => [user ?? '', outlet ?? ''];
}

final class ProfileError extends ProfileState {
  final ErrorEntity error;
  const ProfileError({required this.error});

  @override
  List<Object> get props => [error];
}
