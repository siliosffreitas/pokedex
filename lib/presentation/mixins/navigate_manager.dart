import 'package:get/get.dart';

mixin NavigateManager {
  var _navigateTo = RxString();

  Stream<String> get navigateToStream => _navigateTo.stream;

  set navigateTo(String route) => _navigateTo.value = route;
}
