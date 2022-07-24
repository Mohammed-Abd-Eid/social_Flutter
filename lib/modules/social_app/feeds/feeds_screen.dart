// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_is_empty

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialm/layout/social_app/cubit/cubit.dart';
import 'package:socialm/layout/social_app/cubit/state.dart';
import 'package:socialm/models/social_model/social_post.dart';
import 'package:socialm/shared/styles/icon_broken.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context)!.posts.length > 0 &&
              SocialCubit.get(context)!.model != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 7,
                  margin: EdgeInsets.all(5),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/handsome-cheerful-man-points-copy-space-dressed-black-clothes-wears-headset-smiles-toothily-demonstrates-advertisement-isolated-yellow-background_273609-34029.jpg?t=st=1646137793~exp=1646138393~hmac=73402e584c2bb3ed04d4bdf33b0d8e8d699035ec4d95cfb216a7bcca8dcc216a&w=996'),
                        fit: BoxFit.cover,
                        height: 250,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "communicate with friends",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPost(
                      SocialCubit.get(context)!.posts[index], context, index),
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemCount: SocialCubit.get(context)!.posts.length,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPost(PostModel postModel, context, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage("${postModel.image}")),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${postModel.name}",
                              style: TextStyle(height: 1.4),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.check_circle,
                              color: Colors.blueAccent,
                              size: 15,
                            )
                          ],
                        ),
                        Text(
                          "${postModel.dateTame}",
                          style: TextStyle(
                              color: Colors.grey, fontSize: 12, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              Text(
                "${postModel.text}",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          end: 6.0, top: 10, bottom: 10),
                      child: Container(
                        height: 25,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: Text(
                            "#software",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (postModel.postImage != "")
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        image: NetworkImage("${postModel.postImage}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 16,
                              color: Colors.red,
                            ),
                            SizedBox(width: 5),
                            Text("${SocialCubit.get(context)!.like[index]}"),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              size: 16,
                              color: Colors.amber,
                            ),
                            SizedBox(width: 5),
                            Text("120"),
                            SizedBox(width: 5),
                            Text("Comments"),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                            "${SocialCubit.get(context)!.model!.image}")),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Write a comment ...",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 13, height: 3),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 16,
                              color: Colors.red,
                            ),
                            SizedBox(width: 5),
                            Text("Like"),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    SizedBox(width: 15),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Send,
                              size: 16,
                              color: Colors.green,
                            ),
                            SizedBox(width: 5),
                            Text("Share"),
                          ],
                        ),
                      ),
                      onTap: () {
                        SocialCubit.get(context)!
                            .likePost(SocialCubit.get(context)!.postsId[index]);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
