part of 'tax_bloc.dart';

sealed class TaxEvent extends Equatable {
  const TaxEvent();

  @override
  List<Object> get props => [];
}

final class FetchTaxList extends TaxEvent {}
