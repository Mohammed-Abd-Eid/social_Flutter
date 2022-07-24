abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialUserLoadingState extends SocialStates {}

class SocialUserSuccessState extends SocialStates {}

class SocialUserErrorState extends SocialStates {
  final String error;

  SocialUserErrorState(this.error);
}

class SocialChangeBottomNav extends SocialStates {}

class SocialNewPostState extends SocialStates {}

//GET COVER & PROFILE & USER
class SocialProfileImageSuccessState extends SocialStates {}

class SocialProfileImageErrorState extends SocialStates {}

class SocialCoverImageSuccessState extends SocialStates {}

class SocialCoverImageErrorState extends SocialStates {}

//UPLOAD COVER & PROFILE & USER
class SocialCoverImageUploadSuccessState extends SocialStates {}

class SocialCoverImageUploadErrorState extends SocialStates {}

class SocialProfileImageUploadSuccessState extends SocialStates {}

class SocialProfileImageUploadErrorState extends SocialStates {}

class SocialUserImageUploadErrorState extends SocialStates {}

class SocialUserUploadLoadingState extends SocialStates {}

//Create Post & post Image
class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImageSuccessState extends SocialStates {}

class SocialPostImageErrorState extends SocialStates {}

class SocialPostImageRemoveState extends SocialStates {}

class SocialUploadPostImageSuccessState extends SocialStates {}

//Get Post & post Image
class SocialGetPostLoadingState extends SocialStates {}

class SocialGetPostSuccessState extends SocialStates {}

class SocialGetPostErrorState extends SocialStates {
  final String error;

  SocialGetPostErrorState(this.error);
}

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}
