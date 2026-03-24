part of 'table_list_bloc.dart';

sealed class TableListState extends Equatable {
  const TableListState();

  @override
  List<Object> get props => [];
}

final class TableListInitial extends TableListState {}

final class TableListLoading extends TableListState {}

final class TableListLoaded extends TableListState {
  final List<TableEntity> tableList;
  const TableListLoaded({required this.tableList});

  @override
  List<Object> get props => [tableList];
}

final class TableListError extends TableListState {
  final ErrorEntity error;
  const TableListError({required this.error});

  @override
  List<Object> get props => [error];
}
