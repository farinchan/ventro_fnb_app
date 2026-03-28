import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/data/models/req/transaction_model.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/sale_entity.dart';
import 'package:ventro_fnb_app/domain/usecase/get_transaction.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransaction getTransaction;
  TransactionBloc({required this.getTransaction})
    : super(TransactionInitial()) {
    on<TransactionSave>((event, emit) async {
      emit(TransactionLoading());
      final result = await getTransaction(event.transactionReqModel);
      result.fold(
        (error) => emit(TransactionError(error: error)),
        (saleEntity) => emit(TransactionLoaded(saleEntity: saleEntity)),
      );
    });
  }
}
