import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core/pdf_template.dart';

class ReceiptCard extends StatelessWidget {
  final String recNo;
  final String paymentDate;
  final String examType;
  final String examMonth;
  final String sem;

  const ReceiptCard({
    super.key,
    required this.recNo,
    required this.paymentDate,
    required this.examType,
    required this.examMonth,
    required this.sem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
         
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.deepOrange.shade50,
                    Colors.deepOrange.shade50,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepOrange.shade200.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              margin: const EdgeInsets.only(top: 20),
              child: Card(
                elevation: 0,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _buildReceiptContent(),
                ),
              ),
            ),

            // Header Chip
            Positioned(
              top: 0,
              left: 24,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade600,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepOrange.shade300.withOpacity(0.5),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  'Receipt Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate()
    .fadeIn(duration: 500.ms)
    .slideY(begin: 0.1, end: 0, duration: 500.ms);
  }

  Widget _buildReceiptContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Receipt Number Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                recNo,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.deepOrange.shade800,
                  letterSpacing: 1.2,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              onPressed: () {
                PdfTemplate().generatePdf(
                  recNo: recNo,
                  paymentDate: paymentDate,
                  examType: examType,
                  examMonth: examMonth,
                  sem: sem,
                );
              },
              icon: Icon(
                Icons.download_rounded,
                color: Colors.deepOrange.shade600,
                size: 30,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16.0),

        // Details Grid
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 3,
          children: [
            _buildDetailColumn('Payment Date', paymentDate),
            _buildDetailColumn('Semester', sem),
            _buildDetailColumn('Exam Type', examType),
            _buildDetailColumn('Exam Month', examMonth),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.deepOrange.shade600,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
