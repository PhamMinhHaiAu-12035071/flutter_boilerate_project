import 'package:flutter/material.dart';
import 'package:flutter_boilerate_project/routers/e_page.dart';

class SignInScreen extends EPage {
  const SignInScreen({required Map<String, dynamic> args}) : super(args: args);

  @override
  Widget build(BuildContext context) {
    return const SignInView();
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
      body: const Center(
        child: Text('This is sign in page'),
      ),
    );
  }
}
