abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  RegisterEvent(this.name, this.email, this.password, this.confirmPassword);
}

class LogoutEvent extends AuthEvent {}
