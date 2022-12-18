import 'package:advanced_app/domain/model/models.dart';
import 'package:advanced_app/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:advanced_app/data/network/failure.dart';
import 'base_usecase.dart';

class StoreDetailsUsecase extends BaseUsecase<void, StoreDetails> {
  final Repository _repository;

  StoreDetailsUsecase(this._repository);

  @override
  Future<Either<Failure, StoreDetails>> execute(void input) async {
    return await _repository.getStoreDeatils();
  }
}


