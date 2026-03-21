import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:ventro_fnb_app/data/datasources/remote/remote_datasource_impl.dart';
import 'package:ventro_fnb_app/data/datasources/remote_datasource.dart';
import 'package:ventro_fnb_app/data/repositories/repository_domain_impl.dart';
import 'package:ventro_fnb_app/domain/repositories/repository_domain.dart';
import 'package:ventro_fnb_app/domain/usecase/get_login.dart';
import 'package:ventro_fnb_app/presentation/bloc/login/login_bloc.dart';

final getIt = GetIt.instance;

void init() {
  //bloc
  getIt.registerFactory(() => LoginBloc(getLogin: getIt()));

  // Use cases
  getIt.registerLazySingleton(() => GetLogin(repository: getIt()));

   // Repositories
  getIt.registerLazySingleton<RepositoryDomain>(
      () => RepositoryDomainImpl(remoteDatasource: getIt()));

  // Data sources
  getIt.registerLazySingleton<RemoteDatasource>(
      () => RemoteDatasourceImpl(client: getIt()));

  // Http service
  getIt.registerLazySingleton(() => http.Client());
}
