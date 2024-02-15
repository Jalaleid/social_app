abstract class SocialLoginStates {}

class SocialLoadingInitialState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSucsessState extends SocialLoginStates {
  final String uId;

  SocialLoginSucsessState(this.uId);
}

class SocialLoginErrorState extends SocialLoginStates {
  final String error;

  SocialLoginErrorState(this.error);
}

class SocialchangePasswordVisibilityState extends SocialLoginStates {}
