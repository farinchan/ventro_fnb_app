import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'outlet_detail_event.dart';
part 'outlet_detail_state.dart';

class OutletDetailBloc extends Bloc<OutletDetailEvent, OutletDetailState> {
  OutletDetailBloc() : super(OutletDetailInitial()) {
    on<OutletDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
