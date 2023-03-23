import 'package:estok_app/entities/stock.dart';

class StockFilterService {
  List<Stock> filterByStatus(List<Stock> stocks, String status) {
    if (status == "TODOS") {
      return stocks;
    } else {
      return stocks
          .where((stockItem) => stockItem.stockStatus == status)
          .toList();
    }
  }
}
