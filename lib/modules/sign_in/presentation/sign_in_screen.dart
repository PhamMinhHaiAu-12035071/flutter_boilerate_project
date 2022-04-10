import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerate_project/configs/dependency_injection/injection.dart';
import 'package:flutter_boilerate_project/modules/sign_in/business_logic/sign_in_bloc.dart';
import 'package:flutter_boilerate_project/modules/sign_in/presentation/widgets/email_input.dart';
import 'package:flutter_boilerate_project/modules/sign_in/presentation/widgets/login_button.dart';
import 'package:flutter_boilerate_project/modules/sign_in/presentation/widgets/password_input.dart';
import 'package:flutter_boilerate_project/modules/sign_in/presentation/widgets/text_error.dart';
import 'package:flutter_boilerate_project/routers/e_page.dart';

class SignInScreen extends EPage {
  const SignInScreen({required Map<String, dynamic> args}) : super(args: args);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignInBloc>(),
      child: const SignInView(),
    );
  }
}

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              EmailInput(),
              Padding(padding: EdgeInsets.all(12)),
              PasswordInput(),
              Padding(padding: EdgeInsets.all(12)),
              LoginButton(),
              Padding(padding: EdgeInsets.all(12)),
              TextError(),
            ],
          ),
        ),
      ),
    );
  }
}
