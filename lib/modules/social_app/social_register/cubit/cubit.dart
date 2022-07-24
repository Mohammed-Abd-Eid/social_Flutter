// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialm/models/social_model/social_user.dart';
import 'package:socialm/modules/social_app/social_register/cubit/state.dart';

class SocialRegisterCubit extends Cubit<SocialState> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit? get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
      print(error.toString());
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel user = SocialUserModel(
        email: email,
        name: name,
        phone: phone,
        uId: uId,
        bio: "write you bio ....",
        image: "https://cdn-icons-png.flaticon.com/512/1053/1053244.png?w=740",
        cover:
            "https://img.freepik.com/free-photo/penne-pasta-tomato-sauce-with-chicken-tomatoes-wooden-table_2829-19744.jpg?t=st=1647184773~exp=1647185373~hmac=5ba6be9f130b615673352383c08e101b398faa6826a961030f512036ba93fd56&w=996",
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(user.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
      print(error.toString());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePassword() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialChangePassword());
  }
}
