import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerate_project/configs/dependency_injection/injection.dart';
import 'package:flutter_boilerate_project/modules/sign_in/business_logic/sign_in_bloc.dart';
import 'package:flutter_boilerate_project/routers/navigation_cubit.dart';
import 'package:flutter_boilerate_project/routers/routes.dart';
import 'package:formz/formz.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);
  static const Key buttonKey =
      ValueKey('loginForm_submitButton_elevatedButton');

  void _navigateToHomePage(BuildContext context) =>
      context.read<NavigationCubit>().push(Path.home);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          _navigateToHomePage(context);
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          key: LoginButton.buttonKey,
          onPressed: state.status.isValidated
              ? () => getIt<SignInBloc>().add(
                    const SignInSubmitted(),
                  )
              : null,
          child: const Text('Submit'),
        );
      },
    );
  }
}
