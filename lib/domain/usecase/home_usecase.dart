import 'package:advanced_app/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:advanced_app/data/network/failure.dart';
import '../model/models.dart';
import 'base_usecase.dart';

class HomeUseCase implements BaseUsecase<void, HomeObject> {
  final Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHomeData();
  }
}
