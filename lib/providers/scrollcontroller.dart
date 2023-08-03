import 'package:flutter/material.dart';

class ScrollControllerProvider with ChangeNotifier {
  ScrollController scrollController = ScrollController();
  void scrollToWidget(DateTime date, List<dynamic> transactions) {
    bool foundItem = false;
    int itemIndex = -1;
    for (int i = 0; i < transactions.length; i++) {
      if (DateTime.parse(transactions[i]['date']) == date) {
        foundItem = true;
        itemIndex = i;
        break;
      }
    }
    if (foundItem) {
      scrollController.animateTo(itemIndex * 103.5,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }
}
