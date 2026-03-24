part of 'table_list_bloc.dart';

sealed class TableListEvent extends Equatable {
  const TableListEvent();

  @override
  List<Object> get props => [];
}

final class FetchTableList extends TableListEvent {}
