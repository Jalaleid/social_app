// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';

import '../../models/post_model.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SocialCubit.get(context).getPosts(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          // If something wrong happened.
          return const Center(child: Text('An error occurred!'));
        }
        return BlocConsumer<SocialCubit, SocialStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      margin: const EdgeInsets.all(8),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          const Image(
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/social.jpg'),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 3),
                            child: const Column(
                              children: [
                                Text(
                                  'Communicate',
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white60),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'with friends',
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white60),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: SocialCubit.get(context).posts.length,
                      itemBuilder: (context, index) => buildPostItem(
                          SocialCubit.get(context).posts[index],
                          index,
                          context),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }

  Widget buildPostItem(PostModel model, index, context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model.name}',
                        style: const TextStyle(
                            height: 1.3,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${model.dateTime}',
                        style: const TextStyle(
                            height: 1.3,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black38),
                      )
                    ],
                  ),
                ),
                // const Spacer(),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Divider(
              color: Colors.black12,
              thickness: 0.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              '${model.text}',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ),
          if (model.imagePost != '')
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image(
                image: NetworkImage('${model.imagePost}'),
                fit: BoxFit.contain,
                //height: 150,
              ),
            ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.thumb_up_alt,
                      size: 20,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${SocialCubit.get(context).likes[index]}',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    )
                  ],
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.comment_outlined,
                      size: 20,
                      color: Colors.amber,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '0 comments',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Divider(
              color: Colors.black12,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 17,
                        backgroundImage: NetworkImage('${model.image}'),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        'Write a comment...',
                        style: TextStyle(color: Colors.black45),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    SocialCubit.get(context)
                        .LikePost(SocialCubit.get(context).postsID[index]);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.thumb_up_alt,
                        size: 20,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Like',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.ios_share_rounded,
                      size: 20,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Share',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
