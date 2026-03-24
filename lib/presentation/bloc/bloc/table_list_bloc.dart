import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/table_entity.dart';
import 'package:ventro_fnb_app/domain/usecase/get_table_list.dart';

part 'table_list_event.dart';
part 'table_list_state.dart';

class TableListBloc extends Bloc<TableListEvent, TableListState> {
  GetTableList getTableList;
  TableListBloc({required this.getTableList}) : super(TableListInitial()) {
    on<FetchTableList>((event, emit) async {
      emit(TableListLoading());
      final result = await getTableList.call();
      result.fold(
        (error) => emit(TableListError(error: error)),
        (tableList) => emit(TableListLoaded(tableList: tableList)),
      );
    });
  }
}
