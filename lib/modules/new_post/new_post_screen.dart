// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:flutter/material.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatPostScreen extends StatelessWidget {
  var textcontroller = TextEditingController();

  CreatPostScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            titleSpacing: 0,
            title: Text(
              "Creat Post",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    var now = DateTime.now();
                    if (SocialCubit.get(context).ImagePost == null) {
                      SocialCubit.get(context).CreatNewPost(
                          text: textcontroller.text, dateTime: now.toString());
                    } else {
                      SocialCubit.get(context).uploadImagePost(
                          text: textcontroller.text, dateTime: now.toString());
                    }
                  },
                  child: const Text("POST"))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                if (state is SocialCreatPostLoadingState)
                  const Column(
                    children: [
                      LinearProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          NetworkImage(SocialCubit.get(context).model!.image!),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jalal Eid',
                            style: TextStyle(
                                height: 1.3,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: textcontroller,
                  decoration: const InputDecoration(
                      hintText: 'What is on your mind...',
                      border: InputBorder.none),
                ),
                if (SocialCubit.get(context).ImagePost != null)
                  Image(
                    image: FileImage(SocialCubit.get(context).ImagePost!),
                    fit: BoxFit.contain,
                    //height: 150,
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        SocialCubit.get(context).getImagePost();
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.photo,
                            color: Colors.blue,
                          ),
                          Text(
                            'Add Photo',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "#  Add tags",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ))
                      ],
                    )
                  ],
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}
