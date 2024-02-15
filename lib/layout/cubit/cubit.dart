// ignore_for_file: depend_on_referenced_packages, avoid_print, non_constant_identifier_names, unnecessary_null_comparison

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chat_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';

import '../../shared/components/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? model;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      print(value.data());
      emit(SocialGetUserSuccsessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialGetUserErrorState(onError.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    CreatPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    "New Post",
    'Users',
    'Settings',
  ];

  void ChangeBottomNav(int index) {
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  ImagePicker picker = ImagePicker();
  File? ProfileImage;

  Future<void> getProfileImage() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      ProfileImage = File(image.path);
      emit(SocialProfilePickedImageSucsessState());
    } else {
      print("No Image Selected");
      emit(SocialProfilePickedImageErrorState());
    }
  }

  void uploadProfile({
    required String? name,
    required String? email,
    required String? phone,
    required String? bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(ProfileImage!.path).pathSegments.last}')
        .putFile(ProfileImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(
            name: name, email: email, bio: bio, phone: phone, image: value);
        emit(SocialUploadProfileImageSucsessState());
      }).catchError((onError) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((onError) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  File? CoverImage;

  Future<void> getCoverImage() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      CoverImage = File(image.path);
      emit(SocialCoverImagePickedSucsessState());
    } else {
      print("No Image Selected");
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadCover({
    required String? name,
    required String? email,
    required String? phone,
    required String? bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(CoverImage!.path).pathSegments.last}')
        .putFile(CoverImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(
            name: name, email: email, bio: bio, phone: phone, cover: value);
        emit(SocialUploadCoverImageSucsessState());
      }).catchError((onError) {});
    }).catchError((onError) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({
    required String? name,
    required String? email,
    required String? phone,
    required String? bio,
    String? image,
    String? cover,
  }) {
    UserModel? updatemodel = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: model!.uId!,
        image: image ?? model!.image!,
        bio: bio,
        cover: cover ?? model!.cover!);
    FirebaseFirestore.instance
        .collection('users')
        .doc(updatemodel.uId)
        .update(updatemodel.toMap())
        .then((value) {
      getUserData();
      emit(SocialUpdateUserSucsessState());
    }).catchError((onError) {
      emit(SocialUpdateUserErrorState());
    });
  }

  File? ImagePost;

  Future<void> getImagePost() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      ImagePost = File(image.path);
      emit(SocialImagePostPickedSucsessState());
    } else {
      print("No Image Selected");
      emit(SocialImagePostPickedErrorState());
    }
  }

  void uploadImagePost({
    required String? text,
    required String? dateTime,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(ImagePost!.path).pathSegments.last}')
        .putFile(ImagePost!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        print(value);
        CreatNewPost(text: text, dateTime: dateTime, ImagePost: value);
        emit(SocialUploadPostImageSucsessState());
      }).catchError((onError) {});
    }).catchError((onError) {
      emit(SocialUploadPostImageErrorState());
    });
  }

  void CreatNewPost({
    required String? text,
    required String? dateTime,
    String? ImagePost,
  }) {
    emit(SocialCreatPostLoadingState());
    PostModel? postmodel = PostModel(
      name: model!.name!,
      text: text,
      dateTime: dateTime,
      uId: model!.uId!,
      image: model!.image!,
      imagePost: ImagePost ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postmodel.toMap())
        .then((value) {
      emit(SocialCreatPostSucsessState());
    }).catchError((onError) {
      emit(SocialCreatPostErrorState());
    });
  }

  late List<PostModel> posts = [];
  late List<String> postsID = [];
  late List<int> likes = [];

  Future<void> getPosts() async {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          posts.add(PostModel.fromJson(element.data()));
          postsID.add(element.id);
        }).catchError((onError) {
          print(onError.toString());
          emit(SocialGetPostsErrorState(onError.toString()));
        });
      }
      emit(SocialGetPostsSuccsessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialGetPostsErrorState(onError.toString()));
    });
  }

  void removePostImge() {
    ImagePost = null;
    emit(SocialRemoveImagePostSucsessState());
  }

  void LikePost(String postID) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postID)
        .collection('likes')
        .doc(model!.uId!)
        .set({'like': true}).then((value) {
      //getPosts();
      emit(SocialLikePostSuccsessState());
    }).catchError((onError) {
      emit(SocialLikePostErrorState(onError.toString()));
    });
  }

  List<UserModel> users = [];

  void getAllUsers() {
    users = [];
    emit(SocialGetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        users.add(UserModel.fromJson(element.data()));
      }

      emit(SocialGetAllUsersSuccsessState());
    }).catchError((onError) {
      emit(SocialGetAllUsersErrorState(onError.toString()));
    });
  }

  void SendMessage(
      {required String text,
      required String dateTime,
      required String receiverID}) {
    MessageModel message = MessageModel(
        senderID: model!.uId,
        receiverID: receiverID,
        date: dateTime,
        text: text);

    // set my chat

    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      emit(SocialSendMessageSucsessState());
    }).catchError((onError) {
      emit(SocialSendMessageErrorState());
    });

    // set receiver chat

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      emit(SocialSendMessageSucsessState());
    }).catchError((onError) {
      emit(SocialSendMessageErrorState());
    });
  }

  late List<MessageModel> messages = [];

  void getMessages({required String receiverID}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId!)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(SocialGetMessagesSucsessState());
    });
  }
}
