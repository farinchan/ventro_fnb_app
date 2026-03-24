import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/tax_entity.dart';
import 'package:ventro_fnb_app/domain/usecase/get_tax_list.dart';

part 'tax_event.dart';
part 'tax_state.dart';

class TaxBloc extends Bloc<TaxEvent, TaxState> {
  GetTaxList getTaxList;
  TaxBloc({required this.getTaxList}) : super(TaxInitial()) {
    on<FetchTaxList>((event, emit) async {
      emit(TaxLoading());
      final result = await getTaxList.call();
      result.fold(
        (error) => emit(TaxError(error: error)),
        (taxList) => emit(TaxLoaded(taxList: taxList)),
      );
    });
  }
}
