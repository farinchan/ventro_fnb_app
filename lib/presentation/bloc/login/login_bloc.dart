import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/login_entity.dart';
import 'package:ventro_fnb_app/domain/usecase/get_login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  GetLogin getLogin;
  LoginBloc({required this.getLogin}) : super(LoginInitial()) {
    on<LoginRequested>((event, emit) {
      emit(LoginLoading());
      getLogin(event.username, event.password).then((result) {
        result.fold((error) => emit(LoginFailure(error)), (login) => emit(LoginSuccess(login)));
      });
    });
  }
}
