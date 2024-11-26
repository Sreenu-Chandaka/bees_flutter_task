import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:animate_do/animate_do.dart';

import '../controllers/complaint_controller.dart';
import '../models/complaint_model.dart';
import '../core/file_picker.dart';
import '../widgets/complaint_card.dart';

class TransportManagementScreen extends StatefulWidget {
  const TransportManagementScreen({super.key});

  @override
  _TransportManagementScreenState createState() =>
      _TransportManagementScreenState();
}

class _TransportManagementScreenState extends State<TransportManagementScreen> {
  final ComplaintController _complaintController =
      Get.put(ComplaintController());
  final TextEditingController _descriptionController = TextEditingController();
  final Uuid _uuid = const Uuid();

  final List<String> _complaintTypes = [
    'Bus Timings',
    'Library Services',
    'Cafeteria Food',
    'Classroom Facilities',
    'Internet Connectivity',
    'Hostel Accommodation',
    'Faculty Availability',
    'Examination Schedule',
    'Sports Facilities',
    'Other',
  ];

  @override
  void dispose() {
    // Important: Always dispose of controllers when not needed
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 227, 241),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: FadeInRight(
          child: Text(
            'Transport Management',
            style: TextStyle(
              color: Colors.indigo[800],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // Complaint Submission Card
                    FadeInUp(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.indigo[300]!,
                              Colors.indigo[500]!,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.indigo.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Complaint Type Dropdown
                              Obx(() => DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.9),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    hint: Text(
                                      'Select Complaint Type',
                                      style:
                                          TextStyle(color: Colors.indigo[800]),
                                    ),
                                    value: _complaintController
                                            .selectedComplaintType.value.isEmpty
                                        ? null
                                        : _complaintController
                                            .selectedComplaintType.value,
                                    onChanged: (value) {
                                      _complaintController
                                          .selectedComplaintType.value = value!;
                                    },
                                    items: _complaintTypes.map((type) {
                                      return DropdownMenuItem<String>(
                                        value: type,
                                        child: Text(type),
                                      );
                                    }).toList(),
                                  )),
                              const SizedBox(height: 16),

                              // Date Picker
                              GestureDetector(
                                onTap: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                    builder: (context, child) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.fromSeed(
                                            seedColor: Colors.indigo,
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (selectedDate != null) {
                                    _complaintController.selectedDate.value =
                                        DateFormat('dd-MM-yyyy')
                                            .format(selectedDate);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.calendar_today,
                                          color: Colors.indigo[800]),
                                      const SizedBox(width: 10),
                                      Obx(() => Text(
                                            _complaintController
                                                    .selectedDate.value.isEmpty
                                                ? 'Select Date'
                                                : _complaintController
                                                    .selectedDate.value,
                                            style: TextStyle(
                                                color: Colors.indigo[800]),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Complaint Description
                              TextField(
                                controller:
                                    _descriptionController, // Use the controller here
                                maxLines: 3,
                                onChanged: (value) {
                                  _complaintController
                                      .complaintDescription.value = value;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Describe your complaint...',
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.9),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // File Picker
                              Row(
                                children: [
                                  Expanded(
                                    child: Obx(() => Text(
                                          _complaintController
                                                  .fileName.value.isEmpty
                                              ? 'No file selected'
                                              : _complaintController.fileName
                                                  .split('/')
                                                  .last,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              overflow: TextOverflow.ellipsis),
                                        )),
                                  ),
                                  GradientButton(
                                    onPressed: () {
                                      FilePickerService()
                                          .pickFile()
                                          .then((fileName) {
                                        if (fileName != null) {
                                          _complaintController.fileName.value =
                                              fileName;
                                        }
                                      });
                                    },
                                    child: Text(
                                      'Pick File',
                                      style:
                                          TextStyle(color: Colors.indigo[800]),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // Submit Complaint Button
                              Center(
                                child: GradientButton(
                                  onPressed: () {
                                    var newComplaint = Complaint(
                                      id: _uuid.v4(),
                                      date: _complaintController.selectedDate
                                          .toString()
                                          .split(' ')[0],
                                      description: _complaintController
                                          .complaintDescription.value,
                                      type: _complaintController
                                          .selectedComplaintType.value,
                                    );
                                    _complaintController
                                        .addComplaint(newComplaint);
                                    _complaintController
                                        .complaintDescription.value = '';
                                    _descriptionController
                                        .clear(); // Clear the controller text

                                    // Unfocus to close keyboard
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: Text(
                                    'Send Complaint',
                                    style: TextStyle(
                                        color: Colors.indigo[800],
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Obx(() => ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _complaintController.complaintList.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            final complaint =
                                _complaintController.complaintList[index];
                            return FadeInUp(
                              delay: Duration(milliseconds: 100 * index),
                              child: Dismissible(
                                  key: Key(complaint.id),
                                  background: _buildSwipeBackground(),
                                  secondaryBackground:
                                      _buildSwipeSecondaryBackground(),
                                  confirmDismiss: (direction) async {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      // Show confirmation dialog for delete
                                      return await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('Delete Complaint',
                                              style: TextStyle(
                                                  color: Colors.indigo[800])),
                                          content: const Text(
                                              'Are you sure you want to delete this complaint?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Colors.indigo[800]),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.red[400],
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop(true);
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              child: const Text('Delete'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    return null;
                                  },
                                  onDismissed: (direction) {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      // Delete the complaint
                                      _complaintController
                                          .deleteComplaint(complaint.id);

                                      // Show a snackbar to confirm deletion
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                            'Complaint deleted',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor: Colors.red[400],
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  },
                                  child: ComplaintCard(
                                    complaint: complaint,
                                    onEdit: (updatedComplaint) {
                                      _complaintController.editComplaint(
                                          complaint.id, updatedComplaint);
                                      FocusScope.of(context).unfocus();
                                    },
                                    onDelete: () {
                                      _complaintController
                                          .deleteComplaint(complaint.id);
                                      FocusScope.of(context).unfocus();
                                    },
                                  )),
                            );
                          },
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Background for swipe-to-delete (start to end)
  Widget _buildSwipeBackground() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 20),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Icon(
        Icons.archive,
        color: Colors.white,
        size: 32,
      ),
    );
  }

  // Background for swipe-to-delete (end to start)
  Widget _buildSwipeSecondaryBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.red[400],
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Icon(
        Icons.delete,
        color: Colors.white,
        size: 32,
      ),
    );
  }

  // Edit Complaint Dialog
  void _showEditComplaintDialog(Complaint complaint) {
    final TextEditingController descriptionController =
        TextEditingController(text: complaint.description);
    String? selectedType = complaint.type;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit Complaint',
          style: TextStyle(color: Colors.indigo[800]),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: selectedType,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Complaint Type',
              ),
              items: _complaintTypes.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                selectedType = value;
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Description',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.indigo[800]),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo[500],
            ),
            onPressed: () {
              // Update the complaint
              final updatedComplaint = Complaint(
                id: complaint.id,
                type: selectedType ?? complaint.type,
                description: descriptionController.text,
                date: complaint.date,
              );

              _complaintController.editComplaint(
                  complaint.id, updatedComplaint);
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

// Custom Gradient Button Widget
class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const GradientButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.8),
              Colors.white.withOpacity(0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: child,
        ),
      ),
    );
  }
}
