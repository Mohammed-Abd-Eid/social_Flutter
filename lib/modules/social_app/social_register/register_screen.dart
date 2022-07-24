// ignore_for_file: must_be_immutable, import_of_legacy_library_into_null_safe, use_key_in_widget_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialm/layout/social_app/social_layout.dart';
import 'package:socialm/modules/social_app/social_register/cubit/cubit.dart';
import 'package:socialm/modules/social_app/social_register/cubit/state.dart';
import 'package:socialm/shared/components/components.dart';
import 'package:socialm/shared/local/cache_helper.dart';

class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SocialRegisterCubit(),
        child: BlocConsumer<SocialRegisterCubit, SocialState>(
          listener: (context, state) {
            if (state is SocialCreateUserSuccessState) {
              navigateAndFinish(context, const SocialLayout());
            }
            if (state is SocialRegisterSuccessState) {
              CacheHelper.saveData(
                key: "uId",
                value: state.uId,
              ).then((value) {
                navigateAndFinish(context, const SocialLayout());
              });
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formKey,
                      child: Center(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "REGISTER",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3
                                      ?.copyWith(color: Colors.black),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  "Register now to browse our hot offers",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(color: Colors.grey),
                                ),
                                const SizedBox(height: 30),
                                defaultFormField(
                                  controller: nameController,
                                  type: TextInputType.text,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return "Please Enter Your Name";
                                    }
                                  },
                                  label: "User Name",
                                  prefix: Icons.person,
                                ),
                                const SizedBox(height: 30),
                                defaultFormField(
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return "Please Enter Your Email";
                                    }
                                  },
                                  label: "Email Address",
                                  prefix: Icons.email_outlined,
                                ),
                                const SizedBox(height: 30),
                                defaultFormField(
                                  controller: passController,
                                  type: TextInputType.visiblePassword,
                                  suffix:
                                      SocialRegisterCubit.get(context)!.suffix,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return "Please Enter Your Password";
                                    }
                                  },
                                  suffixPressed: () {
                                    SocialRegisterCubit.get(context)!
                                        .changePassword();
                                  },
                                  isPassword: SocialRegisterCubit.get(context)!
                                      .isPassword,
                                  onSubmit: (value) {},
                                  label: "Password",
                                  prefix: Icons.lock_outlined,
                                ),
                                const SizedBox(height: 30),
                                defaultFormField(
                                  controller: phoneController,
                                  type: TextInputType.phone,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return "Please Enter Your phone";
                                    }
                                  },
                                  label: "Phone",
                                  prefix: Icons.phone,
                                ),
                                const SizedBox(height: 30),
                                ConditionalBuilder(
                                  condition:
                                      state is! SocialRegisterLoadingState,
                                  builder: (context) => defaultButton(
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        SocialRegisterCubit.get(context)!
                                            .userRegister(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passController.text,
                                          phone: phoneController.text,
                                        );
                                      }
                                    },
                                    text: 'Register',
                                    isUpperCase: true,
                                  ),
                                  fallback: (context) => const Center(
                                      child: CircularProgressIndicator()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
