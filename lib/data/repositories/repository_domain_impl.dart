import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ventro_fnb_app/data/datasources/remote_datasource.dart';
import 'package:ventro_fnb_app/data/models/error_model.dart';
import 'package:ventro_fnb_app/domain/entities/category_entity.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/login_entity.dart';
import 'package:ventro_fnb_app/domain/entities/outlet_entity.dart';
import 'package:ventro_fnb_app/domain/entities/product_entity.dart';
import 'package:ventro_fnb_app/domain/entities/user_entity.dart';
import 'package:ventro_fnb_app/domain/repositories/repository_domain.dart';

class RepositoryDomainImpl implements RepositoryDomain {
  final RemoteDatasource remoteDatasource;
  RepositoryDomainImpl({required this.remoteDatasource});

  @override
  Future<Either<ErrorEntity, LoginEntity>> login(
    String username,
    String password,
  ) async {
    try {
      final result = await remoteDatasource.login(username, password);
      log(
        'Login successful: ${result.toEntity()}',
        name: 'RepositoryDomainImpl',
      );
      return Right(result.toEntity());
    } on ErrorModel catch (e) {
      log(
        'Login error: ${e.toEntity()}',
        name: 'RepositoryDomainImpl',
        error: e,
      );
      return Left(e.toEntity());
    } catch (e) {
      log('Login error: $e', name: 'RepositoryDomainImpl', error: e);
      return Left(
        ErrorEntity(status: "error", message: e.toString(), validation: null),
      );
    }
  }

  @override
  Future<Either<ErrorEntity, UserEntity>> profile() async {
    try {
      final result = await remoteDatasource.profile();
      log(
        'Profile successful: ${result.toEntity()}',
        name: 'RepositoryDomainImpl',
      );
      return Right(result.toEntity());
    } on ErrorModel catch (e) {
      log(
        'Profile error: ${e.toEntity()}',
        name: 'RepositoryDomainImpl',
        error: e,
      );
      return Left(e.toEntity());
    } catch (e) {
      log('Profile error: $e', name: 'RepositoryDomainImpl', error: e);
      return Left(
        ErrorEntity(status: "error", message: e.toString(), validation: null),
      );
    }
  }

  @override
  Future<Either<ErrorEntity, List<OutletEntity>>> outletList() async {
    try {
      final result = await remoteDatasource.outletList();
      log(
        'Outlet list successful: ${result.map((e) => e.toEntity()).toList()}',
        name: 'RepositoryDomainImpl',
      );
      return Right(result.map((e) => e.toEntity()).toList());
    } on ErrorModel catch (e) {
      log(
        'Outlet list error: ${e.toEntity()}',
        name: 'RepositoryDomainImpl',
        error: e,
      );
      return Left(e.toEntity());
    } catch (e) {
      log('Outlet list error: $e', name: 'RepositoryDomainImpl', error: e);
      return Left(
        ErrorEntity(status: "error", message: e.toString(), validation: null),
      );
    }
  }

  @override
  Future<Either<ErrorEntity, OutletEntity>> outletDetail() async {
    try {
      final result = await remoteDatasource.outletDetail();
      log(
        'Outlet detail successful: ${result.toEntity()}',
        name: 'RepositoryDomainImpl',
      );
      return Right(result.toEntity());
    } on ErrorModel catch (e) {
      log(
        'Outlet detail error: ${e.toEntity()}',
        name: 'RepositoryDomainImpl',
        error: e,
      );
      return Left(e.toEntity());
    } catch (e) {
      log('Outlet detail error: $e', name: 'RepositoryDomainImpl', error: e);
      return Left(
        ErrorEntity(status: "error", message: e.toString(), validation: null),
      );
    }
  }

  @override
  Future<Either<ErrorEntity, List<CategoryEntity>>> categoryList() async {
    try {
      final result = await remoteDatasource.categoryList();
      log(
        'Category list successful: ${result.map((e) => e.toEntity()).toList()}',
        name: 'RepositoryDomainImpl',
      );
      return Right(result.map((e) => e.toEntity()).toList());
    } on ErrorModel catch (e) {
      log(
        'Category list error: ${e.toEntity()}',
        name: 'RepositoryDomainImpl',
        error: e,
      );
      return Left(e.toEntity());
    } catch (e) {
      log('Category list error: $e', name: 'RepositoryDomainImpl', error: e);
      return Left(
        ErrorEntity(status: "error", message: e.toString(), validation: null),
      );
    }
  }

  @override
  Future<Either<ErrorEntity, ProductEntity>> productDetail(
    int productId,
  ) async {
    try {
      final result = await remoteDatasource.productDetail(productId);
      log(
        'Product detail successful: ${result.toEntity()}',
        name: 'RepositoryDomainImpl',
      );
      return Right(result.toEntity());
    } on ErrorModel catch (e) {
      log(
        'Product detail error: ${e.toEntity()}',
        name: 'RepositoryDomainImpl',
        error: e,
      );
      return Left(e.toEntity());
    } catch (e) {
      log('Product detail error: $e', name: 'RepositoryDomainImpl', error: e);
      return Left(
        ErrorEntity(status: "error", message: e.toString(), validation: null),
      );
    }
  }

  @override
  Future<Either<ErrorEntity, List<ProductEntity>>> productList() async {
    try {
      final result = await remoteDatasource.productList();
      log(
        'Product list successful: ${result.map((e) => e.toEntity()).toList()}',
        name: 'RepositoryDomainImpl',
      );
      return Right(result.map((e) => e.toEntity()).toList());
    } on ErrorModel catch (e) {
      log(
        'Product list error: ${e.toEntity()}',
        name: 'RepositoryDomainImpl',
        error: e,
      );
      return Left(e.toEntity());
    } catch (e) {
      log('Product list error: $e', name: 'RepositoryDomainImpl', error: e);
      return Left(
        ErrorEntity(status: "error", message: e.toString(), validation: null),
      );
    }
  }
}
