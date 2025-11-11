import 'package:photo_manager/photo_manager.dart';

class FilterOptions {
  static final createdAtDesc = FilterOptionGroup(
    orders: [
      const OrderOption(type: OrderOptionType.createDate, asc: false),
    ],
  );

  static final createdAtAsc = FilterOptionGroup(
    orders: [
      const OrderOption(type: OrderOptionType.createDate, asc: true),
    ],
  );
}
