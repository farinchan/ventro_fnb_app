import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/outlet_entity.dart';
import 'package:ventro_fnb_app/domain/entities/user_entity.dart';
import 'package:ventro_fnb_app/domain/usecase/get_outlet_detail.dart';
import 'package:ventro_fnb_app/domain/usecase/get_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  GetProfile getProfile;
  GetOutletDetail getOutletDetail;
  ProfileBloc({required this.getProfile, required this.getOutletDetail}) : super(ProfileInitial()) {
    on<FetchProfile>((event, emit) async {
      emit(ProfileLoading());
      final user = await getProfile.call();
      final outlet = await getOutletDetail.call();
      user.fold(
        (error) => emit(ProfileError(error: error)),
        (user) => outlet.fold(
          (error) => emit(ProfileError(error: error)),
          (outlet) => emit(ProfileLoaded(user: user, outlet: outlet)),
        ),
      );
    });
  }
}
