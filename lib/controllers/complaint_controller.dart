import 'package:get/get.dart';

import '../models/complaint_model.dart';
// Make sure to import your model file

class ComplaintController extends GetxController {
  var complaintList = <Complaint>[].obs;

  RxString selectedComplaintType = ''.obs;
  RxString selectedDate = ''.obs;
  RxString complaintDescription = ''.obs;
  RxString fileName = ''.obs;

  // Add a new complaint
  void addComplaint(Complaint complaint) {
    complaintList.add(complaint);
  }

  // Delete a complaint by id
  void deleteComplaint(String id) {
    complaintList.removeWhere((complaint) => complaint.id == id);
  }

  // Edit a complaint by id
  void editComplaint(String id, Complaint updatedComplaint) {
    int index = complaintList.indexWhere((complaint) => complaint.id == id);
    if (index != -1) {
      complaintList[index] = updatedComplaint;
    }
  }
}
