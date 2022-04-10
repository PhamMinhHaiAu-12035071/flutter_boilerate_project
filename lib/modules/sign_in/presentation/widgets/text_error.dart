import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerate_project/modules/sign_in/business_logic/sign_in_bloc.dart';

class TextError extends StatelessWidget {
  const TextError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) => previous.error != current.error,
      builder: (context, state) => state.error.isNotEmpty
          ? Text(
              state.error,
              style: const TextStyle(
                color: CupertinoColors.destructiveRed,
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
