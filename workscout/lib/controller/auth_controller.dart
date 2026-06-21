import 'package:get/get.dart';
import 'package:workscout/data/model/job_model.dart';
import 'package:workscout/services/api_client.dart';
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
    if (token != null) {
      await fetchProfile();
    }
    isLoading.value = false;
  }

  Future<void> fetchProfile() async {
    try {
      final response = await ApiClient.get('/auth/profile');
      final data = response['data'] as Map<String, dynamic>?;
      if (data != null) {
        currentUser.value = UserProfile.fromJson(data);
      }
    } catch (_) {
      // Token invalid or network error — stay logged out
      await _tokenStorage.deleteToken();
      isLoggedIn.value = false;
    }
  }

  Future<void> setUserFromLogin(Map<String, dynamic> userData) async {
    currentUser.value = UserProfile.fromJson(userData);
    isLoggedIn.value = true;
    await fetchProfile();
  }

  Future<void> logout() async {
    await _tokenStorage.deleteToken();
    isLoggedIn.value = false;
    currentUser.value = null;
    Get.offAllNamed('/LoginView');
  }
}
