import 'package:flutter/material.dart';
import '../utils/export.dart';

enum OrdersDetailState {
  initial,
  loading,
  loaded,
  error,
}

enum OrdersState {
  initial,
  loading,
  loaded,
  loadingMore,
  error,
}

class OrdersProvider extends ChangeNotifier {
  String message = '';
  OrdersState ordersState = OrdersState.initial;

  late SellerOrder sellerOrderData;
  List<SellerOrdersListItem> sellerOrdersList = [];

  late DeliveryBoyOrder deliveryBoyOrderData;
  List<DeliveryBoyOrdersListItem> deliveryBoyOrdersList = [];

  bool hasMoreData = false;
  int totalData = 0;
  int offset = 0;
  int selectedStatus = 0;

  getOrders({
    required String statusIndex,
    required BuildContext context,
  }) async {
    if (offset == 0) {
      ordersState = OrdersState.loading;
      notifyListeners();
    } else {
      ordersState = OrdersState.loadingMore;
      notifyListeners();
    }

    try {
      Map<String, String> params = {};
      params[ApiAndParams.status] = statusIndex;
      params[ApiAndParams.limit] =
          Constant.defaultDataLoadLimitAtOnce.toString();
      params[ApiAndParams.offset] = offset.toString();

      Map<String, dynamic> getData =
          (await getOrdersRepository(context: context, params: params));

      if (getData[ApiAndParams.status].toString() == "1") {
        if (Constant.session.isSeller() == true) {
          sellerOrderData = SellerOrder.fromJson(getData);
          totalData = getData[ApiAndParams.total];
          List<SellerOrdersListItem> tempOrders =
              sellerOrderData.data?.orders ?? [];

          sellerOrdersList.addAll(tempOrders);

          hasMoreData = totalData > sellerOrdersList.length;
          if (hasMoreData) {
            offset += Constant.defaultDataLoadLimitAtOnce;
          }
        } else {
          deliveryBoyOrderData = DeliveryBoyOrder.fromJson(getData);
          totalData = getData[ApiAndParams.total];
          List<DeliveryBoyOrdersListItem> tempOrders =
              deliveryBoyOrderData.data?.orders ?? [];

          deliveryBoyOrdersList.addAll(tempOrders);

          hasMoreData = totalData > deliveryBoyOrdersList.length;
          if (hasMoreData) {
            offset += Constant.defaultDataLoadLimitAtOnce;
          }
        }
      }

      ordersState = OrdersState.loaded;
      notifyListeners();
    } catch (e) {
      if (context.mounted) {
        message = e.toString();
        ordersState = OrdersState.error;
        GeneralMethods.showSnackBarMsg(context, message);
        notifyListeners();
      }
    }
  }

  Future<bool> changeOrderSelectedStatus(int index) async {
    if (selectedStatus.toString() != index.toString()) {
      selectedStatus = index;
      notifyListeners();
      offset = 0;
      sellerOrdersList = [];
      deliveryBoyOrdersList = [];
      return true;
    } else {
      return false;
    }
  }
}
