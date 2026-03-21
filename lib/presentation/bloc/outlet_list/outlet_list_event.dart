part of 'outlet_list_bloc.dart';

sealed class OutletListEvent extends Equatable {
  const OutletListEvent();

  @override
  List<Object> get props => [];
}

final class FetchOutletList extends OutletListEvent {}
