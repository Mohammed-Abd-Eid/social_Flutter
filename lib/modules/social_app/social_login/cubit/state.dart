abstract class SocialState {}

class SocialLoginInitialState extends SocialState {}

class SocialLoginLoadingState extends SocialState {}

class SocialLoginSuccessState extends SocialState {
  final String uId;

  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends SocialState {
  final String error;

  SocialLoginErrorState(this.error);
}

class SocialChangePassword extends SocialState {}
