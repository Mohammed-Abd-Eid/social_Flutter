// ignore_for_file: import_of_legacy_library_into_null_safe, use_key_in_widget_constructors, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialm/layout/social_app/social_layout.dart';
import 'package:socialm/modules/social_app/social_login/cubit/cubit.dart';
import 'package:socialm/modules/social_app/social_login/cubit/state.dart';
import 'package:socialm/modules/social_app/social_register/register_screen.dart';
import 'package:socialm/shared/local/cache_helper.dart';

import '../../../shared/components/components.dart';

class SocialLogin extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SocialLoginCubit(),
        child: BlocConsumer<SocialLoginCubit, SocialState>(
          listener: (context, state) {
            if (state is SocialLoginErrorState) {
              showToast(text: state.error, state: ToastStates.ERROR);
            }
            if (state is SocialLoginSuccessState) {
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
              appBar: AppBar(elevation: 0),
              body: Form(
                key: formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "LOGIN",
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(color: Colors.black),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "login now to browse our hot offers",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.grey),
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
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                // SocialLoginCubit.get(context).userLogin(
                                //   email: emailController.text,
                                //   password: passController.text,
                                // );
                              }
                            },
                            label: "Email Address",
                            prefix: Icons.email_outlined,
                          ),
                          const SizedBox(height: 30),
                          defaultFormField(
                            controller: passController,
                            type: TextInputType.visiblePassword,
                            suffix: SocialLoginCubit.get(context).suffix,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return "Please Enter Your Password";
                              }
                            },
                            suffixPressed: () {
                              SocialLoginCubit.get(context).changePassword();
                            },
                            isPassword:
                                SocialLoginCubit.get(context).isPassword,
                            label: "Password",
                            prefix: Icons.lock_outlined,
                          ),
                          const SizedBox(height: 30),
                          ConditionalBuilder(
                            condition: state is! SocialLoginLoadingState,
                            builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passController.text,
                                  );
                                }
                              },
                              text: 'Login',
                              isUpperCase: true,
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                  onPressed: () {
                                    navigatorTo(
                                      context,
                                      SocialRegisterScreen(),
                                    );
                                  },
                                  child: const Text(
                                    'register',
                                  )),
                            ],
                          ),
                        ],
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
