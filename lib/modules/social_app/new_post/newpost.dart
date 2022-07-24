// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialm/layout/social_app/cubit/cubit.dart';
import 'package:socialm/layout/social_app/cubit/state.dart';
import 'package:socialm/shared/components/components.dart';
import 'package:socialm/shared/styles/icon_broken.dart';

class NewPost extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: "Create Post",
            actions: [
              defaultTextButton(
                  function: () {
                    var now = DateTime.now();
                    if (SocialCubit.get(context)!.postImage == null) {
                      SocialCubit.get(context)!.createPost(
                        dateTame: now.toString(),
                        text: textController.text,
                      );
                    } else {
                      SocialCubit.get(context)!.uploadPostImage(
                        text: textController.text,
                        dateTame: now.toString(),
                      );
                    }
                  },
                  text: "Post"),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState) SizedBox(height: 5),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/closeup-shot-handsome-male-smiling_181624-41237.jpg?t=st=1646138885~exp=1646139485~hmac=2bcfb0df4ecc2f95b175c31e1347577a7459377e1c624c47b1329d8129d45a69&w=900'),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        "Mohammed Eid",
                        style: TextStyle(height: 1.4),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: "What is on your mind .....",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                if (SocialCubit.get(context)!.postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image: FileImage(
                                SocialCubit.get(context)!.postImage as File),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          SocialCubit.get(context)!.removePostImage();
                        },
                        icon: CircleAvatar(
                          radius: 20,
                          child: Icon(IconBroken.Close_Square, size: 16),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context)!.getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image),
                            Text("  Add Photos"),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text("# tags"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
