part of 'sale_mode_list_bloc.dart';

sealed class SaleModeListState extends Equatable {
  const SaleModeListState();
  
  @override
  List<Object> get props => [];
}

final class SaleModeListInitial extends SaleModeListState {}

final class SaleModeListLoading extends SaleModeListState {}

final class SaleModeListLoaded extends SaleModeListState {
  final List<SaleModeEntity> saleModeList;
  const SaleModeListLoaded({required this.saleModeList});

  @override
  List<Object> get props => [saleModeList];
}

final class SaleModeListError extends SaleModeListState {
  final ErrorEntity error;
  const SaleModeListError({required this.error});

  @override
  List<Object> get props => [error];
}
  