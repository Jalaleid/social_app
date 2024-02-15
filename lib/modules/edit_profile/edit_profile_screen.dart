// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var fromKey = GlobalKey<FormState>();
        var emailcontroller = TextEditingController();
        var biocontroller = TextEditingController();
        var phonecontroller = TextEditingController();
        var namecontroller = TextEditingController();
        var UserModel = SocialCubit.get(context).model;
        var ProfileImage = SocialCubit.get(context).ProfileImage;
        var CoverImage = SocialCubit.get(context).CoverImage;

        emailcontroller.text = UserModel!.email!;
        biocontroller.text = UserModel.bio!;
        phonecontroller.text = UserModel.phone!;
        namecontroller.text = UserModel.name!;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Edit Profile",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            titleSpacing: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              TextButton(
                  onPressed: () {
                    SocialCubit.get(context).updateUser(
                        name: namecontroller.text,
                        email: emailcontroller.text,
                        phone: phonecontroller.text,
                        bio: biocontroller.text);
                  },
                  child: const Text('UPDATE')),
              const SizedBox(
                width: 8,
              )
            ],
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  if (state is SocialUpdateUserLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 220,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                height: 190,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    image: DecorationImage(
                                        // image:
                                        //     NetworkImage('${UserModel.cover}'),
                                        image: CoverImage != null
                                            ? FileImage(CoverImage)
                                                as ImageProvider<Object>
                                            : NetworkImage(
                                                '${UserModel.cover}'),
                                        fit: BoxFit.cover)),
                              ),
                              IconButton(
                                  splashRadius: 25,
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: const CircleAvatar(
                                    backgroundColor: Colors.black45,
                                    radius: 25,
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 20,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 65,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    //NetworkImage('${UserModel.image}'),
                                    ProfileImage != null
                                        ? FileImage(ProfileImage)
                                            as ImageProvider<Object>?
                                        : NetworkImage('${UserModel.image}'),
                              ),
                            ),
                            IconButton(
                                splashRadius: 25,
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: const CircleAvatar(
                                  backgroundColor: Colors.black45,
                                  radius: 25,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 20,
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (SocialCubit.get(context).ProfileImage != null ||
                      SocialCubit.get(context).CoverImage != null)
                    Column(
                      children: [
                        Row(
                          children: [
                            if (SocialCubit.get(context).ProfileImage != null)
                              Expanded(
                                  child: ElevatedButton(
                                child: const Text("Upload Profile"),
                                onPressed: () {
                                  SocialCubit.get(context).uploadProfile(
                                      name: namecontroller.text,
                                      email: emailcontroller.text,
                                      phone: phonecontroller.text,
                                      bio: biocontroller.text);
                                },
                              )),
                            const SizedBox(
                              width: 5,
                            ),
                            if (SocialCubit.get(context).CoverImage != null)
                              Expanded(
                                  child: ElevatedButton(
                                child: const Text("Upload Cover"),
                                onPressed: () {
                                  SocialCubit.get(context).uploadCover(
                                      name: namecontroller.text,
                                      email: emailcontroller.text,
                                      phone: phonecontroller.text,
                                      bio: biocontroller.text);
                                },
                              ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  Form(
                    key: fromKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: namecontroller,
                          decoration: const InputDecoration(
                            label: Text('Name'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Username must not empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: biocontroller,
                          decoration: const InputDecoration(
                            label: Text('Bio'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.info),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Write your bio';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailcontroller,
                          decoration: const InputDecoration(
                            label: Text('Email'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email must not empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: phonecontroller,
                          decoration: const InputDecoration(
                            label: Text('Phone'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone must not empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
