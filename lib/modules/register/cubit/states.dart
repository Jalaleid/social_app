
abstract class SocialRegisterStates {}

class SocialLoadingInitialState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSucsessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;

  SocialRegisterErrorState(this.error);
}


class SocialCreatUserSucsessState extends SocialRegisterStates {}

class SocialCreatUserErrorState extends SocialRegisterStates {
  final String error;

  SocialCreatUserErrorState(this.error);
}

class SocialchangePasswordVisibilityState extends SocialRegisterStates {}
