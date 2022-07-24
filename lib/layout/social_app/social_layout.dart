// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialm/layout/social_app/cubit/cubit.dart';
import 'package:socialm/layout/social_app/cubit/state.dart';
import 'package:socialm/modules/social_app/new_post/newpost.dart';
import 'package:socialm/shared/components/components.dart';
import 'package:socialm/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          navigatorTo(context, NewPost());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit!.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Search),
              )
            ],
          ),
          body: cubit.screens![cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: "Chat",
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Paper_Upload),
                label: "Post",
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Location),
                label: "Location",
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label: "Setting",
              )
            ],
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
          ),
        );
      },
    );
  }
}

// if (!FirebaseAuth.instance.currentUser!.emailVerified)
// Container(
// color: Colors.amber.withOpacity(0.6),
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 12),
// child: Row(
// children: [
// Icon(Icons.info_outline),
// SizedBox(width: 15),
// Expanded(child: Text("please verify your email")),
// SizedBox(width: 20),
// defaultTextButton(
// function: () {
// FirebaseAuth.instance.currentUser!
//     .sendEmailVerification()
//     .then((value) {
// showToast(
// text: "Check your email",
// state: ToastStates.SUCCESS);
// }).catchError((error) {});
// },
// text: "send",
// ),
// ],
// ),
// ),
// )
