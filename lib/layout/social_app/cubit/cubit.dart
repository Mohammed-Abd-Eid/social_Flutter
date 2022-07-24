// ignore_for_file: prefer_const_constructors, avoid_print, deprecated_member_use, avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialm/layout/social_app/cubit/state.dart';
import 'package:socialm/models/social_model/social_post.dart';
import 'package:socialm/models/social_model/social_user.dart';
import 'package:socialm/modules/social_app/chats/chats_screen.dart';
import 'package:socialm/modules/social_app/feeds/feeds_screen.dart';
import 'package:socialm/modules/social_app/new_post/newpost.dart';
import 'package:socialm/modules/social_app/settings/settings_screen.dart';
import 'package:socialm/modules/social_app/users/users_screen.dart';
import 'package:socialm/shared/components/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit? get(context) => BlocProvider.of(context);
  SocialUserModel? model;

  void getUserData() {
    emit(SocialUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      model = SocialUserModel.fromJson(value.data()!);
      emit(SocialUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget>? screens = [
    FeedScreen(),
    ChatsScreen(),
    NewPost(),
    UserScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNav());
    }
  }

  File? profileImage;
  File? coverImage;
  File? postImage;

  final picker = ImagePicker();

  Future getProfileImage() async {
    final pickerFile = await picker.getImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      profileImage = File(pickerFile.path);
      emit(SocialProfileImageSuccessState());
    } else {
      print("No Image Selected");

      emit(SocialProfileImageErrorState());
    }
  }

  Future<void> getCoverImage() async {
    final pickerFile = await picker.getImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      coverImage = File(pickerFile.path);
      emit(SocialCoverImageSuccessState());
    } else {
      print("No Image Selected");
      emit(SocialCoverImageErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialProfileImageUploadSuccessState());
        uploadUser(
          name: name,
          phone: phone,
          bio: bio,
          profile: value,
        );
      }).catchError((error) {
        emit(SocialProfileImageUploadErrorState());
      });
    }).catchError((error) {
      emit(SocialProfileImageUploadErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialCoverImageUploadSuccessState());
        uploadUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialCoverImageUploadErrorState());
      });
    }).catchError((error) {
      emit(SocialCoverImageUploadErrorState());
    });
  }

  void uploadUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? profile,
  }) {
    SocialUserModel user = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: model!.email,
      cover: cover ?? model!.cover,
      image: profile ?? model!.image,
      uId: model!.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(model!.uId)
        .update(user.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserImageUploadErrorState());
    });
  }

  Future<void> getPostImage() async {
    final pickerFile = await picker.getImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      postImage = File(pickerFile.path);
      emit(SocialPostImageSuccessState());
    } else {
      print("No Image Selected");
      emit(SocialPostImageErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialPostImageRemoveState());
  }

  void uploadPostImage({
    required String dateTame,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("posts/${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          dateTame: dateTame,
          text: text,
          postImage: value,
        );
        emit(SocialUploadPostImageSuccessState());
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTame,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel postModel = PostModel(
      name: model!.name,
      image: model!.image,
      uId: model!.uId,
      text: text,
      dateTame: dateTame,
      postImage: postImage ?? "",
    );
    FirebaseFirestore.instance
        .collection("posts")
        .add(postModel.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> like = [];

  void getPost() {
    FirebaseFirestore.instance.collection("posts").get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection("likes").get().then((value) {
          like.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((onError) {});
      });
      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      emit(SocialGetPostErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({"like": true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {});
  }
}
