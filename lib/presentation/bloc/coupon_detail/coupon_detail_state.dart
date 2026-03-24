part of 'coupon_detail_bloc.dart';

sealed class CouponDetailState extends Equatable {
  const CouponDetailState();
  
  @override
  List<Object> get props => [];
}

final class CouponDetailInitial extends CouponDetailState {}

final class CouponDetailLoading extends CouponDetailState {}

final class CouponDetailLoaded extends CouponDetailState {
  final CouponEntity coupon;
  const CouponDetailLoaded({required this.coupon});

  @override
  List<Object> get props => [coupon];
}

final class CouponDetailError extends CouponDetailState {
  final ErrorEntity error;
  const CouponDetailError({required this.error});

  @override
  List<Object> get props => [error];
}
