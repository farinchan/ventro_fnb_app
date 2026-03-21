import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/outlet_entity.dart';
import 'package:ventro_fnb_app/domain/usecase/get_outlet_list.dart';

part 'outlet_list_event.dart';
part 'outlet_list_state.dart';

class OutletListBloc extends Bloc<OutletListEvent, OutletListState> {
  final GetOutletList getOutletList;
  OutletListBloc({required this.getOutletList}) : super(OutletListInitial()) {
    on<FetchOutletList>((event, emit) async {
      emit(OutletListLoading());
      final result = await getOutletList();
      result.fold(
        (error) => emit(OutletListError(error: error)),
        (outlets) => emit(OutletListLoaded(outlets: outlets)),
      );
    });
  }
}
