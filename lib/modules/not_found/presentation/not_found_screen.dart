import 'package:flutter/material.dart';
import 'package:flutter_boilerate_project/routers/e_page.dart';

class NotFoundScreen extends EPage {
  const NotFoundScreen({required Map<String, dynamic> args})
      : super(args: args);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('This is not found screen'),
    );
  }
}
