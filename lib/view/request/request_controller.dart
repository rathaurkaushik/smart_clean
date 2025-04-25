import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:smart_clean/model/request.dart';
import 'package:smart_clean/view/screens/utils/toast_maasage.dart';


class RequestController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var filter = 'All'.obs;

  late CollectionReference requestRef;
  List<RequestModel> requestsList = [];

  @override
  void onInit() {
    requestRef = firestore.collection('requests');
    fetchReqList();  // 👈 Fetch on load
   // Just assign collection here
    super.onInit();
  }

  Future<void> fetchReqList() async {
    try {
      QuerySnapshot requestSnapshot = await requestRef.get(); // Apply ordering here

      print("Request List: ${requestSnapshot.docs.length}");

      final List<RequestModel> retrivedRequestList = requestSnapshot.docs
          .map((doc) => RequestModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      requestsList.assignAll(retrivedRequestList);
      update();
    } catch (e) {
      print("Request error: $e");
      Utils().toastMessageWarning(e.toString());
    }
  }

  void fetchFilteredReqList(String status) async {
    try {
      QuerySnapshot requestSnapshot;

      // Choose query based on filter
      if (status == 'All') {
        requestSnapshot = await requestRef.get();
      } else {
        requestSnapshot = await requestRef
            .where('status', isEqualTo: status)
            .get();
      }

      final List<RequestModel> retrievedRequestList = requestSnapshot.docs
          .map((doc) =>
          RequestModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      requestsList = retrievedRequestList;
      update(); // 👈 ensures GetBuilder rebuilds

      print("Filtered Requests (${status}): ${requestsList.length}");
    } catch (e) {
      print("Error fetching filtered requests: $e");
      Utils().toastMessageWarning("Failed to fetch $status requests");
    }
  }


}
