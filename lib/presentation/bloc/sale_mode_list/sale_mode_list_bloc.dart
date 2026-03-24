import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/sale_mode_entity.dart';
import 'package:ventro_fnb_app/domain/usecase/get_sale_mode_list.dart';

part 'sale_mode_list_event.dart';
part 'sale_mode_list_state.dart';

class SaleModeListBloc extends Bloc<SaleModeListEvent, SaleModeListState> {
  GetSaleModeList getSaleModeList;
  SaleModeListBloc({required this.getSaleModeList})
    : super(SaleModeListInitial()) {
    on<FetchSaleModeList>((event, emit) async {
      emit(SaleModeListLoading());
      final result = await getSaleModeList.call();
      result.fold(
        (error) => emit(SaleModeListError(error: error)),
        (saleModeList) => emit(SaleModeListLoaded(saleModeList: saleModeList)),
      );
    });
  }
}
