class LoginRequest {
  String email;
  String password;
  LoginRequest(this.email, this.password);
}

class RegisterRequest {
  String email;
  String password;
  String userName;
  String countryMobilCode;
  String mobileNumber;
  String profilePicture;

  RegisterRequest(
    this.userName,
    this.countryMobilCode,
    this.mobileNumber,
    this.email,
    this.password,
    this.profilePicture,
  );
}
