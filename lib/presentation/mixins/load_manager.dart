import 'package:get/get.dart';

mixin LoadManager {
  var _isLoading = false.obs;

  Stream<bool> get isLoadingStream => _isLoading.stream;

  set isLoading(bool isLoading) => _isLoading.value = isLoading;
}
