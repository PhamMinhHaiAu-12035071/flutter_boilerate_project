import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerate_project/routers/e_page.dart';
import 'package:flutter_boilerate_project/routers/navigation_cubit.dart';
import 'package:flutter_boilerate_project/routers/routes.dart';

class HomeScreen extends EPage {
  const HomeScreen({required Map<String, dynamic> args}) : super(args: args);

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  void _onNavigateToDetailProductPage(BuildContext context) =>
      context.read<NavigationCubit>().push(Path.detailProduct);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Hero(
              tag: 'imageHero',
              child: Image.network('https://picsum.photos/250?image=9'),
            ),
            ElevatedButton(
              onPressed: () => _onNavigateToDetailProductPage(context),
              child: const Text('Go to detail product'),
            ),
          ],
        ),
      ),
    );
  }
}
