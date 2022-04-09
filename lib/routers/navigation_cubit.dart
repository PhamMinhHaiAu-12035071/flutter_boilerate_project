import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerate_project/routers/navigation_stack.dart';
import 'package:flutter_boilerate_project/routers/page_config.dart';

class NavigationCubit extends Cubit<NavigationStack> {
  NavigationCubit(List<PageConfig> initialPages)
      : super(NavigationStack(initialPages));

  void push(String path, [Map<String, dynamic>? args]) {
    final config = PageConfig(location: path, args: args);
    emit(state.push(config));
  }

  void clearAndPush(String path, [Map<String, dynamic>? args]) {
    final config = PageConfig(location: path, args: args);
    emit(state.clearAndPush(config));
  }

  void pop() {
    emit(state.pop());
  }

  bool canPop() {
    return state.canPop();
  }

  void pushBeneathCurrent(String path, [Map<String, dynamic>? args]) {
    final config = PageConfig(location: path, args: args);
    emit(state.pushBeneathCurrent(config));
  }

  bool isBackHistory(PageConfig config) {
    return state.isBackHistory(config);
  }
}
