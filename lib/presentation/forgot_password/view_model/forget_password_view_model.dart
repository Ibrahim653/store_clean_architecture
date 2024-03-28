import 'dart:async';

import 'package:advanced_app/app/functions.dart';
import 'package:advanced_app/domain/usecase/forget_password_usecase.dart';
import 'package:advanced_app/presentation/base/base_view_model.dart';

import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class ForgetPasswordViewModel extends BaseViewModel
    implements ForgetPasswordInputs, ForgetPasswordOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();
  final ForgetPasswordUseCase forgetPasswordUseCase;

  var email = '';

  ForgetPasswordViewModel(this.forgetPasswordUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }

  @override
  forgotPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));
    (await forgetPasswordUseCase.execute(email)).fold(
        (failure) => // left -> failure
            inputState.add(ErrorState(
              failure.message,
              StateRendererType.popUpErrorState,
            )),
        (supportMessage) => inputState.add(SuccessState(supportMessage)));
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((isAllInputsValid) => _isAllInputsValid());

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  bool _isAllInputsValid() {
    return isEmailValid(email);
  }

  _validate() {
    return inputIsAllInputsValid.add(null);
  }
}

abstract class ForgetPasswordInputs {
  setEmail(String email);
  forgotPassword();
  Sink get inputEmail;
  Sink get inputIsAllInputsValid;
}

abstract class ForgetPasswordOutputs {
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsAllInputsValid;
}
