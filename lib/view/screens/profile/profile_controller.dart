import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_clean/model/users_model.dart';
import 'package:smart_clean/view/screens/utils/toast_maasage.dart';

class ProfileController extends GetxController {



  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late CollectionReference? usersCollection;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var isLoading = false.obs;

  // list of users
  Rx<UsersModel?> user = Rx<UsersModel?>(null);
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    usersCollection = firestore.collection('users');
  }

  /// get users details from firebase

  Future<void> getUsersData(String uid) async {
    DocumentSnapshot usersSnapshot = await usersCollection!.doc(uid).get();
    if (usersSnapshot.exists) {
      user.value =
          UsersModel.fromJson(usersSnapshot.data() as Map<String, dynamic>);
      update();
    } else {
      print('User not found!');
    }
  }

  /// firebase  reset user data
  ///
  Future<void> resetAccount(String uid) async {
    String name = nameController.text.trim();
    String number = numberController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = confirmPasswordController.text.trim();

    // delete uid
    if (name.isEmpty ||
        number.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        cPassword.isEmpty) {
      Utils().toastMessageWarning("All fields are required");
      return;
    }
    if (password != cPassword) {
      Utils().toastMessageSimple("password does not match");
      return;
    } else {
      try {
        isLoading.value = true;
        // delete document from firebase
        await firestore.collection('users').doc(uid).delete();
        print('user deleted successfully');
        UserCredential userCredential= await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        User? user = userCredential.user;

        // user create after assign values in firestore

        if(user!= null){
          await firestore.collection('users').doc(user.uid).set({
            'name' : name,
            'number' : number,
            'email': email,
            'uid' : user.uid
          });
        }
        Utils().toastMessageSimple("Reset an account successfully!");
        Get.offAllNamed("/login");// Uncomment when you have a HomeScreen
        isLoading.value = false;
        update();
      } catch (e) {
        Utils().toastMessageWarning(e.toString());
      }
    }
  }

  Future<void> logout() async{
    try{
      await _auth.signOut();
      Get.offAllNamed('/login');
      Utils().toastMessageSimple("Logout Successful");
    }
    catch(e){
      Utils().toastMessageWarning(e.toString());
    }
    await _auth.signOut();

  }
}
