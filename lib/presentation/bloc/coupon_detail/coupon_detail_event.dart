part of 'coupon_detail_bloc.dart';

sealed class CouponDetailEvent extends Equatable {
  const CouponDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchCouponDetail extends CouponDetailEvent {
  final String code;

  const FetchCouponDetail({required this.code});

  @override
  List<Object> get props => [code];
}
  
  
