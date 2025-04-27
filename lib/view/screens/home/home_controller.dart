import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_clean/model/activities_model.dart';
import 'package:smart_clean/services/notification_services.dart';
import 'package:smart_clean/view/screens/home/raise_request.dart';
import 'package:smart_clean/view/screens/utils/toast_maasage.dart';

class HomeController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  late CollectionReference activityRef;
  final List<ActivitiesModel> activityList = [];

  /// notification Services
  NotificationServices notificationServices = NotificationServices();

  /// Stores user-selected address from LocationScreen
  String? selectedLocation;
  var isLoading = false.obs; // Observable for loading state

  @override
  void onInit() {
    notificationServices.requestNotificationPermission();
    notificationServices.getToken().then((value){
      print("Device token value: ${value}");
    });
    notificationServices.firebaseInit();
    activityRef = firestore.collection('requests');
    getActivities();
    super.onInit();
  }

  /// Opens the camera and navigates to the RaiseRequest screen with captured image
  void openCamera() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final File imageFile = File(image.path);
      Get.to(() => RaiseRequest(imagePath: imageFile)); // Pass File, not String
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

  /// Get user details
  Future<Map<String, String>> getUserInfo() async {
    final uid = _auth.currentUser!.uid;
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userDoc.exists) {
      final name = userDoc['name'];
      final phone = userDoc['phone'];
      return {"name": name, "phone": phone};
    } else {
      throw Exception("User not found");
    }
  }

  /// Upload image to Firebase Storage
  Future<String> uploadImage(File imageFile) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = storage.ref().child('photos/$fileName.jpg');

    await ref.putFile(imageFile);
    print("photo uploaded");
    return await ref.getDownloadURL();
  }

  /// Set data in Firebase
  Future<void> sendRequestData(File imageFile, address) async {
    isLoading.value = true; // Start loading
    update(); // Update the UI when loading starts

    final userInfo = await getUserInfo(); // Fetch name & phone number
    final photoUrl = await uploadImage(imageFile);
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

      await requestRef.set(requestData);
      Utils().toastMessageSimple("Report Submitted");
    } catch (e) {
      print(e.toString());
      Utils().toastMessageWarning("Report not submitted");
    } finally {
      isLoading.value = false; // End loading
      update(); // Update the UI when loading ends
    }
  }

  /// Get activities from Firestore
  Future<void> getActivities() async {
    try {
      QuerySnapshot activitySnapshot = await activityRef.get();
      final List<ActivitiesModel> retrivedActivity =
      activitySnapshot.docs.map((doc) => ActivitiesModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
      activityList.assignAll(retrivedActivity);
    } catch (e) {
      Utils().toastMessageWarning('Stats not visible');
      print(e.toString());
    } finally {
      update();
    }
  }

  /// Get time difference as text
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
