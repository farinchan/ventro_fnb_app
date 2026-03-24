part of 'outlet_detail_bloc.dart';

sealed class OutletDetailState extends Equatable {
  const OutletDetailState();
  
  @override
  List<Object> get props => [];
}

final class OutletDetailInitial extends OutletDetailState {}
