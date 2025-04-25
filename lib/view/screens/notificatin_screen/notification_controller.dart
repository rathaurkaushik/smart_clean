import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_clean/model/activities_model.dart';
import 'package:smart_clean/view/screens/home/raise_request.dart';
import 'package:smart_clean/view/screens/utils/toast_maasage.dart';

class NotificationController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  late CollectionReference activityRef;
  final List<ActivitiesModel> activityList = [];

  /// Stores user-selected address from LocationScreen
  String? selectedLocation;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    activityRef = firestore.collection('requests');
    getActivities();
    super.onInit();
  }

  /// Opens the camera and navigates to the RaiseRequest screen with captured image
  void openCamera() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final File imageFile = File(image.path);
      Get.to(
            () => RaiseRequest(imagePath: imageFile),
      ); // ✅ pass File, not String
      print('📸 Image path: ${image.path}');
    } else {
      print('❌ No image taken');
    }
  }

  /// Sets the selected location and updates UI
  void updateSelectedLocation(String location) {
    selectedLocation = location;
    update(); // Important for GetBuilder to rebuild
    print('📍 Location updated: $location');
  }

  ///
  /// get user details
  ///
  Future<Map<String, String>> getUserInfo() async {
    final uid = _auth.currentUser!.uid;
    final userDoc =
    await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userDoc.exists) {
      final name = userDoc['name'];
      print('Name: ${name}');
      final phone = userDoc['phone'];
      print('phone ${phone}');

      return {"name": name, "phone": phone};
    } else {
      throw Exception("User not found");
    }
  }

  ///
  /// get image
  ///
  Future<String> uploadImage(File imageFile) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = storage.ref().child('photos/$fileName.jpg');

    await ref.putFile(imageFile);
    print("photo uploaded");
    print("${ref.getDownloadURL}");
    return await ref.getDownloadURL();
  }

  /// set data in firebase
  Future<void> sendRequestData(File imageFile, address) async {
    isLoading.value = true;
    final userInfo = await getUserInfo(); // ← fetch name & phone number
    final photoUrl = await uploadImage(imageFile);
    print("move to ref");

    final requestRef = FirebaseFirestore.instance.collection('requests').doc();
    try {
      final requestData = {
        "id": requestRef.id,
        "name": userInfo["name"],
        "phone": userInfo["phone"],
        "image": photoUrl,
        "status": "Pending",
        "address": address,
        "createdAt": FieldValue.serverTimestamp(), // Server timestamp
        "acceptedAt": "", // Initially blank
        "completedAt": "", // Initially blank
      };
      print("hello");
      await requestRef.set(requestData);
      Utils().toastMessageSimple("Report Submitted");
      isLoading.value = false;
      Get.back();
    } catch (e) {
      print(e.toString());
      Utils().toastMessageWarning("Report not submitted");
      isLoading.value = false;
    }
  }

  /// Activities

  Future<void> getActivities() async {
    try {
      QuerySnapshot activitySnapshot = await activityRef.get();
      print(("activity find: ${activitySnapshot.docs.length}"));

      final List<ActivitiesModel> retrivedActivity =
      activitySnapshot.docs.map((doc) =>
          ActivitiesModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
      activityList.assignAll(retrivedActivity);

    } catch (e) {
      Utils().toastMessageWarning('Stats not visible');
      print(e.toString());

    }
    finally{
      update();
    }
  }

  /// get time
  String getTimeDifferenceText(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inMinutes <= 40) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 60) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }



}
