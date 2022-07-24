// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, must_be_immutable, deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialm/layout/social_app/cubit/cubit.dart';
import 'package:socialm/layout/social_app/cubit/state.dart';
import 'package:socialm/shared/components/components.dart';
import 'package:socialm/shared/styles/icon_broken.dart';

class EditProfile extends StatelessWidget {
//  const EditProfile({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var socialMoudel = SocialCubit.get(context)!.model;
          dynamic profileImage = SocialCubit.get(context)!.profileImage;
          dynamic coverImage = SocialCubit.get(context)!.coverImage;
          nameController.text = socialMoudel!.name as String;
          bioController.text = socialMoudel.bio as String;
          phoneController.text = socialMoudel.phone as String;
          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: "Edit Profile",
              actions: [
                defaultTextButton(
                    function: () {
                      SocialCubit.get(context)!.uploadUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                      );
                    },
                    text: "UpDate"),
                SizedBox(width: 15),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is SocialUserUploadLoadingState)
                      LinearProgressIndicator(),
                    if (state is SocialUserUploadLoadingState)
                      SizedBox(height: 10),
                    Container(
                      height: 230,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 180,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4),
                                        topRight: Radius.circular(4)),
                                    image: DecorationImage(
                                      image: coverImage == null
                                          ? NetworkImage(
                                              '${socialMoudel.cover}')
                                          : FileImage(coverImage)
                                              as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context)!.getCoverImage();
                                  },
                                  icon: CircleAvatar(
                                    radius: 20,
                                    child: Icon(IconBroken.Camera, size: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                radius: 64,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage("${socialMoudel.image}")
                                      : FileImage(profileImage)
                                          as ImageProvider,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context)!.getProfileImage();
                                },
                                icon: CircleAvatar(
                                  radius: 20,
                                  child: Icon(IconBroken.Camera, size: 16),
                                ),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    if (SocialCubit.get(context)!.profileImage != null ||
                        SocialCubit.get(context)!.coverImage != null)
                      Row(
                        children: [
                          if (SocialCubit.get(context)!.profileImage != null)
                            Expanded(
                                child: defaultButton(
                                    function: () {
                                      SocialCubit.get(context)!
                                          .uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                      );
                                    },
                                    text: "UPLOAD PROFILE")),
                          SizedBox(width: 8),
                          if (SocialCubit.get(context)!.coverImage != null)
                            Expanded(
                              child: defaultButton(
                                  function: () {
                                    SocialCubit.get(context)!
                                        .uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  text: "UPLOAD COVER"),
                            ),
                        ],
                      ),
                    SizedBox(height: 22),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "Name must not Empty";
                        }
                      },
                      label: "Name",
                      prefix: IconBroken.User,
                    ),
                    SizedBox(height: 15),
                    defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "bio must not Empty";
                        }
                      },
                      label: "Bio",
                      prefix: IconBroken.Info_Circle,
                    ),
                    SizedBox(height: 15),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return "Phone must not Empty";
                        }
                      },
                      label: "Phone",
                      prefix: IconBroken.Call,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
