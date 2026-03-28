part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class TransactionSave extends TransactionEvent {
  final TransactionReqModel transactionReqModel;
  const TransactionSave({required this.transactionReqModel});

  @override
  List<Object> get props => [transactionReqModel];
}


class TransactionPayCash extends TransactionEvent {
  final TransactionReqModel transactionReqModel;
  const TransactionPayCash({required this.transactionReqModel});

  @override
  List<Object> get props => [transactionReqModel];
}

class TransactionPayQris extends TransactionEvent {
  final TransactionReqModel transactionReqModel;
  const TransactionPayQris({required this.transactionReqModel});

  @override
  List<Object> get props => [transactionReqModel];
}

class TransactionPayOther extends TransactionEvent {
  final TransactionReqModel transactionReqModel;
  const TransactionPayOther({required this.transactionReqModel});

  @override
  List<Object> get props => [transactionReqModel];
}


  