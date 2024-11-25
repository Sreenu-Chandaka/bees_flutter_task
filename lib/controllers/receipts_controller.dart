import 'package:get/get.dart';
import '../models/receipt_model.dart';
import '../widgets/receipt_card.dart';

class ReceiptsController extends GetxController {
  var query = ''.obs;
  var receiptsList = <ReceiptCard>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadReceipts();
  }

  void loadReceipts() {
    // Initialize the receiptsList with data
    receiptsList.addAll(ReceiptCardList().receiptCards);
  }

  void updateQuery(String newQuery) {
    query.value = newQuery;
  }

  List<ReceiptCard> get filteredList {
    return receiptsList.where((card) {
      return card.recNo.contains(query.value);
    }).toList();
  }
}
