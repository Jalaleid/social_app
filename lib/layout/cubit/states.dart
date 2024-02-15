abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccsessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccsessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final String error;

  SocialGetAllUsersErrorState(this.error);
}

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccsessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String error;

  SocialGetPostsErrorState(this.error);
}

class SocialLikePostSuccsessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

// Upload Prfile Image

class SocialProfilePickedImageSucsessState extends SocialStates {}

class SocialProfilePickedImageErrorState extends SocialStates {}

class SocialUploadProfileImageSucsessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

// Upload Cover Image

class SocialCoverImagePickedSucsessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialUploadCoverImageSucsessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

// Update User

class SocialUpdateUserLoadingState extends SocialStates {}

class SocialUpdateUserErrorState extends SocialStates {}

class SocialUpdateUserSucsessState extends SocialStates {}

// Creat Post

class SocialImagePostPickedErrorState extends SocialStates {}

class SocialImagePostPickedSucsessState extends SocialStates {}

class SocialUploadPostImageSucsessState extends SocialStates {}

class SocialUploadPostImageErrorState extends SocialStates {}

class SocialCreatPostLoadingState extends SocialStates {}

class SocialCreatPostErrorState extends SocialStates {}

class SocialCreatPostSucsessState extends SocialStates {}

class SocialRemoveImagePostSucsessState extends SocialStates {}

// Message

class SocialSendMessageSucsessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

class SocialGetMessagesSucsessState extends SocialStates {}

class SocialGetMessagesErrorState extends SocialStates {}
