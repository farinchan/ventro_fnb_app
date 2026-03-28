part of 'transaction_bloc.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

final class TransactionInitial extends TransactionState {}

final class TransactionLoading extends TransactionState {}

final class TransactionLoaded extends TransactionState {
  final SaleEntity saleEntity;
  const TransactionLoaded({required this.saleEntity});

  @override
  List<Object> get props => [saleEntity];
}

final class TransactionSaved extends TransactionState {
  final SaleEntity saleEntity;
  const TransactionSaved({required this.saleEntity});

  @override
  List<Object> get props => [saleEntity];
}

final class TransactionQris extends TransactionState {
  final SaleEntity saleEntity;
  const TransactionQris({required this.saleEntity});

  @override
  List<Object> get props => [saleEntity];
}

final class TransactionError extends TransactionState {
  final ErrorEntity error;
  const TransactionError({required this.error});

  @override
  List<Object> get props => [error];
}
