// ignore_for_file: depend_on_referenced_packages, avoid_print, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously, unnecessary_null_comparison, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/models/user_model.dart';
import 'states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialLoadingInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  UserModel? model;

  void UserRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      CreatUser(name: name, email: email, uId: value.user!.uid, phone: phone);
      emit(SocialRegisterSucsessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(SocialRegisterErrorState(Error));
    });
  }

  void CreatUser({
    required String name,
    required String email,
    required String uId,
    required String phone,
  }) {
    UserModel model = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        image: "https://static.thenounproject.com/png/4851855-200.png",
        bio: "Write your bio...",
        cover:
            'https://cdn5.vectorstock.com/i/1000x1000/00/24/neon-night-city-background-cover-retro-vector-13950024.jpg');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreatUserSucsessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(SocialCreatUserErrorState(Error));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswoedVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialchangePasswordVisibilityState());
  }
}
