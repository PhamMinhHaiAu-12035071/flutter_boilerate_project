import 'package:flutter/material.dart';
import 'package:flutter_boilerate_project/configs/dependency_injection/injection.dart';
import 'package:flutter_boilerate_project/localization/app_localization.dart';
import 'package:flutter_boilerate_project/modules/theme/business_logic/theme_bloc.dart';
import 'package:flutter_boilerate_project/modules/theme/constants/enums.dart';
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

  void _toggleTheme() {
    getIt<ThemeBloc>().add(
      const ThemeChanged(
        lightTheme: AppTheme.custom,
        darkTheme: AppTheme.custom,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(AppLocalization.of(context)?.helloWorld ?? '-'),
            ElevatedButton(
              onPressed: _toggleTheme,
              child: const Text('change theme'),
            )
          ],
        ),
      ),
    );
  }
}
