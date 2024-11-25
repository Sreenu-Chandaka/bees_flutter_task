// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:bees_flutter_task/core/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../controllers/complaint_controller.dart';
import '../models/complaint_model.dart';
import '../widgets/complaint_card.dart';
import 'package:intl/intl.dart';

class TransportManagementScreen extends StatefulWidget {
  const TransportManagementScreen({super.key});

  @override
  _TransportManagementScreenState createState() =>
      _TransportManagementScreenState();
}

class _TransportManagementScreenState extends State<TransportManagementScreen> {
  final ComplaintController complaintController =
      Get.put(ComplaintController());

  final Uuid uuid = Uuid();

  final List<String> complaintTypes = [
    'Bus Timings',
    'Other',
    'Library Services',
    'Cafeteria Food',
    'Classroom Facilities',
    'Internet Connectivity',
    'Hostel Accommodation',
    'Faculty Availability',
    'Examination Schedule',
    'Sports Facilities',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Transport Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            children: [
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField<String>(
                        hint: const Text('Select Complaint Type'),
                        value: complaintController
                                .selectedComplaintType.value.isEmpty
                            ? null
                            : complaintController.selectedComplaintType.value,
                        onChanged: (value) {
                          complaintController.selectedComplaintType.value =
                              value!;
                        },
                        items: complaintTypes.map((type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16.0),
                      InkWell(
                        onTap: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (selectedDate != null) {
                            complaintController.selectedDate.value =
                                DateFormat('dd-MM-yyyy').format(selectedDate);
                          }
                          print(selectedDate);
                          print(complaintController.selectedDate);
                          print("is it saving or not");
                        },
                        child: Row(
                          children: [
                            const Text('Select Date: '),
                            Text(complaintController.selectedDate.value),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        maxLines: 3,
                        onChanged: (value) {
                          complaintController.complaintDescription.value =
                              value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Complaint Description',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              complaintController.fileName.split('/').last,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              FilePickerService().pickFile().then((fileName) {
                                if (fileName != null) {
                                  complaintController.fileName.value = fileName;
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xFF2196F3),
                            ),
                            child: const Text('Pick File'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          // Add new complaint
                          var newComplaint = Complaint(
                            id: uuid.v4(),
                            date: complaintController.selectedDate
                                .toString()
                                .split(' ')[0],
                            description:
                                complaintController.complaintDescription.value,
                            type:
                                complaintController.selectedComplaintType.value,
                          );
                          complaintController.addComplaint(newComplaint);
                          complaintController.complaintDescription.value = '';
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF2196F3),
                        ),
                        child: const Text('Send Complaint'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: complaintController.complaintList.length,
                    itemBuilder: (context, index) {
                      final complaint =
                          complaintController.complaintList[index];
                      return ComplaintCard(
                        complaint: complaint,
                        onEdit: (updatedComplaint) {
                          complaintController.editComplaint(
                              complaint.id, updatedComplaint);
                        },
                        onDelete: () {
                          complaintController.deleteComplaint(complaint.id);
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
