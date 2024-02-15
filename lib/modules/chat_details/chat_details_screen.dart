// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel model;
  var textcontroller = TextEditingController();
  ChatDetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(receiverID: model.uId!);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black,
                ),
              ),
              title: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(model.image!),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.name!,
                                style: const TextStyle(
                                    height: 1.3,
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ]),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition: state is! SocialGetMessagesErrorState,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            var message =
                                SocialCubit.get(context).messages[index];
                            if (SocialCubit.get(context).model!.uId! ==
                                message.senderID) {
                              return buildMyMessage(message);
                            }

                            return buildMessage(message);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: SocialCubit.get(context).messages.length),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: textcontroller,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                hintText: 'type your message here...',
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).SendMessage(
                                          text: textcontroller.text,
                                          dateTime: DateTime.now().toString(),
                                          receiverID: model.uId!);
                                      textcontroller.clear();
                                    },
                                    icon: const Icon(
                                      Icons.send,
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      );
    });
  }
}

Widget buildMyMessage(MessageModel model) {
  return Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10),
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
        color: Colors.blue[200],
      ),
      child: Text(model.text!),
    ),
  );
}

Widget buildMessage(MessageModel model) {
  return Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10),
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
        color: Colors.grey[300],
      ),
      child: Text(model.text!),
    ),
  );
}
