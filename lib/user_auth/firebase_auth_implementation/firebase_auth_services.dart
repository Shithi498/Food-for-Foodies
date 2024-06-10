

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices{

 final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email,String password)
  async {
try{
UserCredential userCredential =await auth.createUserWithEmailAndPassword(email: email, password: password);
  return userCredential.user;

}catch(e){
  print("Error: $e");
  return null;
}

}

  Future<User?> signInWithEmailAndPassword(String email,String password)
  async {
    try{
      UserCredential userCredential =await auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;

    }catch(e){
      print("Sonme error found");
    }
    return null;
  }
}