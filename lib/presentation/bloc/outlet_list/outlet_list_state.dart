part of 'outlet_list_bloc.dart';

sealed class OutletListState extends Equatable {
  const OutletListState();
  
  @override
  List<Object> get props => [];
}

final class OutletListInitial extends OutletListState {}

final class OutletListLoading extends OutletListState {}

final class OutletListLoaded extends OutletListState {
  final List<OutletEntity> outlets;

  const OutletListLoaded({required this.outlets});

  @override
  List<Object> get props => [outlets];
}

final class OutletListError extends OutletListState {
  final ErrorEntity error;

  const OutletListError({required this.error});

  @override
  List<Object> get props => [error];
}
