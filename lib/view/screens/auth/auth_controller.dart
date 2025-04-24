import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_clean/view/screens/utils/toast_maasage.dart';

class AuthController extends GetxController {
  // Firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // Controllers for text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController =
  TextEditingController();

  // Reactive variable to track loading state
  var isLoading = false.obs;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    numberController.dispose();
    super.dispose();
  }

  // Sign-up function with validation and error handling
  Future<void> signUp() async {

    if (!formKey.currentState!.validate()) {
      return;
    }
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    String name = nameController.text.trim();
    String number = numberController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty || name.isEmpty || number.isEmpty) {
      Utils().toastMessageWarning("All fields are required");
      return;
    }

    if (password != confirmPassword) {
      Utils().toastMessageWarning("Passwords does not match");
      return;
    } else {
      try {
        isLoading.value = true; // Show loading indicator
       UserCredential userCredential =  await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
       User? user = userCredential.user;

       // add name and phone number
      if(user!= null){
          // Add user details in firebase

        await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
            {
              'name' : name,
              'number' : number,
              'email': email,
              'uid' : user.uid

            });

      }

        Utils().toastMessageSimple("Account created successfully!");
        // Navigate to another screen after successful signup
        Get.offAllNamed("/");// Uncomment when you have a HomeScreen
        isLoading.value = false;
      } catch (e) {
        Utils().toastMessageWarning('Sign Up Failed' + e.toString());
        isLoading.value = false;
      } finally {
        isLoading.value = false; // Hide loading indicator
update();
      }
    }
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Utils().toastMessageWarning('All fields are required');
      isLoading.value = false;
      return;
    } else {
      try {
        isLoading.value = true;
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        Utils().toastMessageSimple("Login Successfully");

        Get.offAllNamed("/");

      } catch (e) {
        Utils().toastMessageWarning(e.toString());

      }finally{
        isLoading.value = false;
        update();
      }
    }
  }
}
