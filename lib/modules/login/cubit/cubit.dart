// ignore_for_file: depend_on_referenced_packages, avoid_print, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';



class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoadingInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void UserLogin({required String email, required String password}) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).
    then((value){
      emit(SocialLoginSucsessState(value.user!.uid));
    }).catchError((onError){
      emit(SocialLoginErrorState(onError.toString()));
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

  // function to implement the google signin

// creating firebase instance
}
