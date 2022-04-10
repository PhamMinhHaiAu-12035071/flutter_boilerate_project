import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerate_project/configs/dependency_injection/injection.dart';
import 'package:flutter_boilerate_project/modules/sign_in/business_logic/sign_in_bloc.dart';
import 'package:flutter_boilerate_project/modules/sign_in/models/password.dart';
import 'package:formz/formz.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({Key? key}) : super(key: key);
  static const Key passwordKey = ValueKey('loginForm_passwordInput_textField');

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          _controller.text = '';
        }
      },
      builder: (context, state) {
        return TextFormField(
          key: PasswordInput.passwordKey,
          controller: _controller,
          onChanged: (String password) => getIt<SignInBloc>().add(
            SignInPasswordChanged(password: password),
          ),
          decoration: InputDecoration(
            icon: const Icon(Icons.lock),
            labelText: 'Password',
            errorText: state.password.invalid
                ? state.password.error == PasswordValidateError.empty
                    ? 'Password is not empty'
                    : null
                : null,
          ),
          obscureText: true,
        );
      },
    );
  }
}
