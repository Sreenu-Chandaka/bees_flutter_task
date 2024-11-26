// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../widgets/receipt_card.dart';
// import '../controllers/receipts_controller.dart'; // Import the controller

// class ReceiptsScreen extends StatelessWidget {
//   ReceiptsScreen({super.key});

//   final ReceiptsController receiptsController = Get.put(ReceiptsController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.indigo.shade50,
//       appBar: AppBar(
//         title: const Text('Receipts'),
//         backgroundColor: const Color(0xFF3F51B5), // Indigo app bar color
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               decoration: const InputDecoration(
//                 hintText: 'Search receipts',
//                 border: OutlineInputBorder(),
//                 suffixIcon: Icon(Icons.search),
//                 fillColor: Colors.white, // White text field background
//                 filled: true,
//               ),
//               onChanged: (value) {
//                 receiptsController.updateQuery(value);
//               },
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: Obx(() {
//                 final filteredList = receiptsController.filteredList;
//                 return ListView.builder(
//                   itemCount: filteredList.length,
//                   itemBuilder: (context, index) {
//                     final cardValue = filteredList[index];
//                     return Column(
//                       children: [
//                         ReceiptCard(
//                           recNo: cardValue.recNo,
//                           paymentDate: cardValue.paymentDate,
//                           examType: cardValue.examType,
//                           examMonth: cardValue.examMonth,
//                           sem: cardValue.sem,
//                         ),
//                         const SizedBox(height: 16),
//                       ],
//                     );
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animations/animations.dart'; // Add animations package
import '../widgets/receipt_card.dart';
import '../controllers/receipts_controller.dart';

class ReceiptsScreen extends StatelessWidget {
  ReceiptsScreen({super.key});

  final ReceiptsController receiptsController = Get.put(ReceiptsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Soft background color
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Receipts',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.1,
          ),
        ),
        backgroundColor: const Color(0xFF3B4FE4), // Vibrant indigo
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF3B4FE4),
                const Color(0xFF7B64FF),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list_rounded, color: Colors.white),
            onPressed: () {
              // TODO: Implement filter functionality
            },
          ),
        ],
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
                    offset: Offset(0, 4),
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
                    borderSide: BorderSide(
                      color: const Color(0xFF3B4FE4),
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
                      SizedBox(height: 16),
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
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final cardValue = filteredList[index];
                  return OpenContainer(
                    closedElevation: 0,
                    openElevation: 0,
                    closedBuilder: (context, action) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: ReceiptCard(
                        recNo: cardValue.recNo,
                        paymentDate: cardValue.paymentDate,
                        examType: cardValue.examType,
                        examMonth: cardValue.examMonth,
                        sem: cardValue.sem,
                      ),
                    ),
                    openBuilder: (context, action) => ReceiptDetailScreen(receipt: cardValue),
                    transitionDuration: Duration(milliseconds: 500),
                    transitionType: ContainerTransitionType.fadeThrough,
                  );
                },
                physics: BouncingScrollPhysics(),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// Optional: Detail Screen for Receipts
class ReceiptDetailScreen extends StatelessWidget {
  final dynamic receipt;

  const ReceiptDetailScreen({Key? key, required this.receipt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Receipt Details',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Receipt Number', receipt.recNo),
                  _buildDetailRow('Payment Date', receipt.paymentDate),
                  _buildDetailRow('Exam Type', receipt.examType),
                  _buildDetailRow('Exam Month', receipt.examMonth),
                  _buildDetailRow('Semester', receipt.sem),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
