import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/domain/entities/coupon_entity.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/usecase/get_coupon_detail.dart';

part 'coupon_detail_event.dart';
part 'coupon_detail_state.dart';

class CouponDetailBloc extends Bloc<CouponDetailEvent, CouponDetailState> {
  final GetCouponDetail getCouponDetail;
  CouponDetailBloc({required this.getCouponDetail})
    : super(CouponDetailInitial()) {
    on<FetchCouponDetail>((event, emit) async {
      emit(CouponDetailLoading());
      final result = await getCouponDetail(event.code);
      result.fold(
        (error) => emit(CouponDetailError(error: error)),
        (coupon) => emit(CouponDetailLoaded(coupon: coupon)),
      );
    });
  }
}
