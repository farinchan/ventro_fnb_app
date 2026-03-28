import 'package:dartz/dartz.dart';
import 'package:ventro_fnb_app/data/models/req/transaction_model.dart';
import 'package:ventro_fnb_app/domain/entities/error_entity.dart';
import 'package:ventro_fnb_app/domain/entities/sale_entity.dart';
import 'package:ventro_fnb_app/domain/repositories/repository_domain.dart';

class GetTransaction {
  final RepositoryDomain repository;
  GetTransaction({required this.repository});

  Future<Either<ErrorEntity, SaleEntity>> call(TransactionReqModel transactionReqModel) {
    return repository.transaction(transactionReqModel);
  }
}