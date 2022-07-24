// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialm/layout/social_app/cubit/cubit.dart';
import 'package:socialm/layout/social_app/cubit/state.dart';
import 'package:socialm/modules/social_app/edit-profile/edit_profile_screen.dart';
import 'package:socialm/shared/components/components.dart';
import 'package:socialm/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var socialMoudel = SocialCubit.get(context)!.model;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 230,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4)),
                          image: DecorationImage(
                            image: NetworkImage("${socialMoudel!.cover}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        radius: 64,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              NetworkImage("${socialMoudel.image}"),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Text(
                "${socialMoudel.name}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                "${socialMoudel.bio}",
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "100",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              "Posts",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "200",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              "Photos",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "100",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              "Followers",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "64",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              "Friends",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text('Add Image'),
                    ),
                  ),
                  SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () {
                      navigatorTo(context, EditProfile());
                    },
                    child: Icon(
                      IconBroken.Edit,
                      size: 16,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
