import 'package:advanced_app/data/network/requests.dart';
import 'package:advanced_app/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:advanced_app/data/network/failure.dart';
import '../model/models.dart';
import 'base_usecase.dart';

class RegisterUseCase
    implements BaseUsecase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput registerInput) async {
    return await _repository.register(RegisterRequest(
        registerInput.userName,
        registerInput.countryMobilCode,
        registerInput.mobileNumber,
        registerInput.email,
        registerInput.password,
        registerInput.profilePicture));
  }
}

class RegisterUseCaseInput {
 String userName;
  String countryMobilCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;

  RegisterUseCaseInput(this.userName, this.countryMobilCode, this.mobileNumber, this.email, this.password, this.profilePicture);


}
