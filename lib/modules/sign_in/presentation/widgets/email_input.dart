import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerate_project/configs/dependency_injection/injection.dart';
import 'package:flutter_boilerate_project/modules/sign_in/business_logic/sign_in_bloc.dart';
import 'package:flutter_boilerate_project/modules/sign_in/models/email.dart';
import 'package:formz/formz.dart';

class EmailInput extends StatefulWidget {
  const EmailInput({Key? key}) : super(key: key);
  static const Key emailKey = ValueKey('loginForm_emailInput_textField');

  @override
  State<EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          _controller.text = '';
          _focusNode.requestFocus();
        }
      },
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: EmailInput.emailKey,
          autofocus: true,
          controller: _controller,
          focusNode: _focusNode,
          onChanged: (String email) => getIt<SignInBloc>().add(
            SignInEmailChanged(email: email),
          ),
          decoration: InputDecoration(
            icon: const Icon(Icons.email),
            labelText: 'Email',
            errorText: state.email.invalid
                ? state.email.error == EmailValidateError.empty
                    ? 'Email is not empty'
                    : null
                : null,
          ),
          keyboardType: TextInputType.emailAddress,
        );
      },
    );
  }
}
