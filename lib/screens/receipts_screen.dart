import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/receipt_card.dart';
import '../controllers/receipts_controller.dart'; // Import the controller

class ReceiptsScreen extends StatelessWidget {
  ReceiptsScreen({super.key});

  final ReceiptsController receiptsController = Get.put(ReceiptsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      appBar: AppBar(
        title: const Text('Receipts'),
        backgroundColor: const Color(0xFF3F51B5), // Indigo app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search receipts',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
                fillColor: Colors.white, // White text field background
                filled: true,
              ),
              onChanged: (value) {
                receiptsController.updateQuery(value);
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                final filteredList = receiptsController.filteredList;
                return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final cardValue = filteredList[index];
                    return Column(
                      children: [
                        ReceiptCard(
                          recNo: cardValue.recNo,
                          paymentDate: cardValue.paymentDate,
                          examType: cardValue.examType,
                          examMonth: cardValue.examMonth,
                          sem: cardValue.sem,
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
