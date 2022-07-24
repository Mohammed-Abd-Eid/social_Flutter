abstract class SocialState {}

class SocialRegisterInitialState extends SocialState {}

class SocialRegisterLoadingState extends SocialState {}

class SocialRegisterSuccessState extends SocialState {
  final String uId;

  SocialRegisterSuccessState(this.uId);
}

class SocialRegisterErrorState extends SocialState {
  final String error;

  SocialRegisterErrorState(this.error);
}

class SocialChangePassword extends SocialState {}

class SocialCreateUserSuccessState extends SocialState {}

class SocialCreateUserErrorState extends SocialState {
  final String error;

  SocialCreateUserErrorState(this.error);
}
