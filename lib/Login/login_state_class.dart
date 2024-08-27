enum LoginStateEnum{
  idle,
  loggedIn,
  loggedOut,
  loading,
  error,
}

class LoginStateClass{

  final LoginStateEnum state;
  final String? errorMessage;
  const LoginStateClass({required this.state, this.errorMessage,});
}