import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/receipts_controller.dart';
import '../widgets/receipt_card.dart';

class ReceiptsScreen extends StatelessWidget {
  ReceiptsScreen({super.key});

  final ReceiptsController receiptsController = Get.put(ReceiptsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Soft background color
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          'Receipts',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.1,
          ),
        ),
        backgroundColor: const Color(0xFF3B4FE4), // Vibrant indigo
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF3B4FE4),
                Color(0xFF7B64FF),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search receipts',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF3B4FE4),
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  receiptsController.updateQuery(value);
                },
              ),
            ),
          ),

          // Receipts List
          Expanded(
            child: Obx(() {
              final filteredList = receiptsController.filteredList;

              if (filteredList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.receipt_long_outlined,
                        size: 80,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No receipts found',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final cardValue = filteredList[index];
                  return ReceiptCard(
                    recNo: cardValue.recNo,
                    paymentDate: cardValue.paymentDate,
                    examType: cardValue.examType,
                    examMonth: cardValue.examMonth,
                    sem: cardValue.sem,
                  );
                },
                physics: const BouncingScrollPhysics(),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// Optional: Detail Screen for Receipts
