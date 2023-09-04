import 'package:flutter/material.dart';

import '../helper/utils/export.dart';

enum OrderInvoiceState {
  initial,
  loading,
  loaded,
  error,
}

class OrderInvoiceProvider extends ChangeNotifier {
  OrderInvoiceState orderInvoiceState = OrderInvoiceState.initial;
  String message = '';
  late Uint8List orderInvoice;

  Future<Uint8List?> getOrderInvoiceApiProvider(
      {required Map<String, dynamic> params,
      required BuildContext context}) async {
    orderInvoiceState = OrderInvoiceState.loading;
    notifyListeners();

    try {
      orderInvoice = await getOrderInvoiceApi(context: context, params: params);

      orderInvoiceState = OrderInvoiceState.loaded;
      notifyListeners();

      return orderInvoice;
    } catch (e) {
      message = e.toString();
      orderInvoiceState = OrderInvoiceState.error;
      if (context.mounted) {
        GeneralMethods.showMessage(
          context,
          message,
          MessageType.warning,
        );
      }
      notifyListeners();
      return null;
    }
  }
}