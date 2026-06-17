import 'package:get/get.dart';
import 'package:workscout/data/model/job_model.dart';
import 'package:workscout/services/token_storage.dart';

class AuthController extends GetxController {
  final TokenStorage _tokenStorage = TokenStorage();

  Rx<UserProfile?> currentUser = Rx<UserProfile?>(null);
  RxBool isLoading = RxBool(true);
  RxBool isLoggedIn = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    checkAuth();
  }

  Future<void> checkAuth() async {
    final token = await _tokenStorage.readToken();
    isLoggedIn.value = token != null;
    isLoading.value = false;
  }

  Future<void> setUserFromLogin(Map<String, dynamic> userData) async {
    currentUser.value = UserProfile.fromJson(userData);
    isLoggedIn.value = true;
  }

  Future<void> logout() async {
    await _tokenStorage.deleteToken();
    isLoggedIn.value = false;
    currentUser.value = null;
    Get.offAllNamed('/LoginView');
  }
}
