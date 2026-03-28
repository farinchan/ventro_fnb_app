import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:ventro_fnb_app/data/datasources/remote/remote_datasource_impl.dart';
import 'package:ventro_fnb_app/data/datasources/remote_datasource.dart';
import 'package:ventro_fnb_app/data/repositories/repository_domain_impl.dart';
import 'package:ventro_fnb_app/domain/repositories/repository_domain.dart';
import 'package:ventro_fnb_app/domain/usecase/get_category_list.dart';
import 'package:ventro_fnb_app/domain/usecase/get_coupon_detail.dart';
import 'package:ventro_fnb_app/domain/usecase/get_coupon_list.dart';
import 'package:ventro_fnb_app/domain/usecase/get_login.dart';
import 'package:ventro_fnb_app/domain/usecase/get_outlet_detail.dart';
import 'package:ventro_fnb_app/domain/usecase/get_outlet_list.dart';
import 'package:ventro_fnb_app/domain/usecase/get_product_list.dart';
import 'package:ventro_fnb_app/domain/usecase/get_profile.dart';
import 'package:ventro_fnb_app/domain/usecase/get_sale_mode_list.dart';
import 'package:ventro_fnb_app/domain/usecase/get_table_list.dart';
import 'package:ventro_fnb_app/domain/usecase/get_tax_list.dart';
import 'package:ventro_fnb_app/domain/usecase/get_transaction.dart';
import 'package:ventro_fnb_app/presentation/bloc/bloc/transaction_bloc.dart';
import 'package:ventro_fnb_app/presentation/bloc/coupon_detail/coupon_detail_bloc.dart';
import 'package:ventro_fnb_app/presentation/bloc/table_list/table_list_bloc.dart';
import 'package:ventro_fnb_app/presentation/bloc/cashier/cashier_bloc.dart';
import 'package:ventro_fnb_app/presentation/bloc/category/category_bloc.dart';
import 'package:ventro_fnb_app/presentation/bloc/login/login_bloc.dart';
import 'package:ventro_fnb_app/presentation/bloc/outlet_list/outlet_list_bloc.dart';
import 'package:ventro_fnb_app/presentation/bloc/profile/profile_bloc.dart';
import 'package:ventro_fnb_app/presentation/bloc/sale_mode_list/sale_mode_list_bloc.dart';

final getIt = GetIt.instance;

void init() {
  //bloc
  getIt.registerFactory(() => LoginBloc(getLogin: getIt()));
  getIt.registerFactory(() => ProfileBloc(getProfile: getIt(), getOutletDetail: getIt()));
  getIt.registerFactory(() => OutletListBloc(getOutletList: getIt()));
  getIt.registerFactory(() => CategoryBloc(getCategoryList: getIt()));
  getIt.registerFactory(() => SaleModeListBloc(getSaleModeList: getIt()));
  getIt.registerFactory(() => TableListBloc(getTableList: getIt()));
  getIt.registerFactory(() => CouponDetailBloc(getCouponDetail: getIt()));
  getIt.registerFactory(
    () => CashierBloc(getProductList: getIt(), getSaleModeList: getIt(), getCouponList: getIt(), getTaxList: getIt()),
  );
  getIt.registerFactory(() => TransactionBloc(getTransaction: getIt()));

  // Use cases
  getIt.registerLazySingleton(() => GetLogin(repository: getIt()));
  getIt.registerLazySingleton(() => GetProfile(repository: getIt()));
  getIt.registerLazySingleton(() => GetOutletList(repository: getIt()));
  getIt.registerLazySingleton(() => GetOutletDetail(repository: getIt()));
  getIt.registerLazySingleton(() => GetProductList(repository: getIt()));
  getIt.registerLazySingleton(() => GetCategoryList(repository: getIt()));
  getIt.registerLazySingleton(() => GetSaleModeList(repository: getIt()));
  getIt.registerLazySingleton(() => GetTableList(repository: getIt()));
  getIt.registerLazySingleton(() => GetTaxList(repository: getIt()));
  getIt.registerLazySingleton(() => GetCouponList(repository: getIt()));
  getIt.registerLazySingleton(() => GetCouponDetail(repository: getIt()));
  getIt.registerLazySingleton(() => GetTransaction(repository: getIt()));

  // Repositories
  getIt.registerLazySingleton<RepositoryDomain>(() => RepositoryDomainImpl(remoteDatasource: getIt()));

  // Data sources
  getIt.registerLazySingleton<RemoteDatasource>(() => RemoteDatasourceImpl(client: getIt()));

  // Http service
  getIt.registerLazySingleton(() => http.Client());
}
