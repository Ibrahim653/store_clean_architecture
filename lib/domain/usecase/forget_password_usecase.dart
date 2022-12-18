import 'package:advanced_app/data/network/failure.dart';
import 'package:advanced_app/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../repository/repository.dart';

class ForgetPasswordUseCase implements BaseUsecase<String, String> {
  final Repository _repository;
  ForgetPasswordUseCase(this._repository);
  @override
  Future<Either<Failure, String>> execute(String email) async {
    return await _repository.forgetPassword(email);
  }
}
