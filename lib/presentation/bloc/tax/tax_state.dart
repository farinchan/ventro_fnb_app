part of 'tax_bloc.dart';

sealed class TaxState extends Equatable {
  const TaxState();
  
  @override
  List<Object> get props => [];
}

final class TaxInitial extends TaxState {}

final class TaxLoading extends TaxState {}

final class TaxLoaded extends TaxState {
  final List<TaxEntity> taxList;
  const TaxLoaded({required this.taxList});

  @override
  List<Object> get props => [taxList];
}

final class TaxError extends TaxState {
  final ErrorEntity error;
  const TaxError({required this.error});

  @override
  List<Object> get props => [error];
}
