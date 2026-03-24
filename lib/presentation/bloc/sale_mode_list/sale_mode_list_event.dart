part of 'sale_mode_list_bloc.dart';

sealed class SaleModeListEvent extends Equatable {
  const SaleModeListEvent();

  @override
  List<Object> get props => [];
}

final class FetchSaleModeList extends SaleModeListEvent {}