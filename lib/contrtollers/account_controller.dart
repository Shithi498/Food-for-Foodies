/**import 'dart:ffi';

import 'package:foodie/data/repository/user_repo.dart';
import 'package:get/get.dart';

import '../user_auth/firebase_auth_implementation/firebase_auth_services.dart';

class AccountController extends GetxController{
  static AccountController get instance => Get.find();
 final _authRepo = Get.put(FirebaseAuthServices());
  final _userRepo = Get.put(UserRepo(apiClient: Get.find()));
  getUserData(){
    final email = _authRepo.auth.currentUser?.email;
    if(email != null){
    return _userRepo.getUserDetails(email!);
  }else{
      Get.snackbar("Error", "Login to continue");
    }
    }
}**/

import 'package:foodie/data/repository/user_repo.dart';
import 'package:get/get.dart';
import '../user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:foodie/models/singup_body_model.dart';

class AccountController extends GetxController {
  static AccountController get instance => Get.find();
   final UserRepo userRepo;
  final _authRepo = Get.put(FirebaseAuthServices());
 // final userRepo = Get.put(UserRepo(apiClient: Get.find()));

  AccountController({required this.userRepo});



  Future<SignUpBody?> loadUserData() async {
    final email = _authRepo.auth.currentUser?.email;
    if (email != null) {
      try {
        final user = await userRepo.getUserDetails(email);
        return user;
      } catch (e) {
        Get.snackbar("Error", "Failed to load user data");
        return null;
      }
    } else {
      Get.snackbar("Error", "Login to continue");
      return null;
    }
  }


}
