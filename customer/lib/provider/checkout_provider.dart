import 'package:flutter/material.dart';

import '../helper/utils/export.dart';
import '../models/initiate_transaction.dart';
import '../models/paytm_transation.dart';

enum CheckoutTimeSlotsState {
  timeSlotsLoading,
  timeSlotsLoaded,
  timeSlotsError,
}

enum CheckoutAddressState {
  addressLoading,
  addressLoaded,
  addressBlank,
  addressError,
}

enum CheckoutDeliveryChargeState {
  deliveryChargeLoading,
  deliveryChargeLoaded,
  deliveryChargeError,
}

enum CheckoutPaymentMethodsState {
  paymentMethodLoading,
  paymentMethodLoaded,
  paymentMethodError,
}

enum CheckoutPlaceOrderState {
  placeOrderLoading,
  placeOrderLoaded,
  placeOrderError,
}

class CheckoutProvider extends ChangeNotifier {
  CheckoutAddressState checkoutAddressState =
      CheckoutAddressState.addressLoading;

  CheckoutDeliveryChargeState checkoutDeliveryChargeState =
      CheckoutDeliveryChargeState.deliveryChargeLoading;

  CheckoutTimeSlotsState checkoutTimeSlotsState =
      CheckoutTimeSlotsState.timeSlotsLoading;

  CheckoutPaymentMethodsState checkoutPaymentMethodsState =
      CheckoutPaymentMethodsState.paymentMethodLoading;

  CheckoutPlaceOrderState checkoutPlaceOrderState =
      CheckoutPlaceOrderState.placeOrderLoading;

  String message = '';
  bool isPaymentUnderProcessing = false;

  //Address variables
  AddressData? selectedAddress = AddressData();

  // Order Delivery charge variables
  double subTotalAmount = 0.0;
  double totalAmount = 0.0;
  double savedAmount = 0.0;
  double deliveryCharge = 0.0;
  List<SellersInfo>? sellerWiseDeliveryCharges;
  DeliveryChargeData? deliveryChargeData;
  bool? isCodAllowed;

  //Timeslots variables
  TimeSlotsData? timeSlotsData;
  bool isTimeSlotsEnabled = true;
  int selectedDate = 0;
  int selectedTime = 0;
  String selectedPaymentMethod = "";

  //Payment methods variables
  PaymentMethods? paymentMethods;
  PaymentMethodsData? paymentMethodsData;

  //Place order variables
  String placedOrderId = "";
  String razorpayOrderId = "";
  String transactionId = "";
  String payStackReference = "";

  String paytmTxnToken = "";

  Future setPaymentProcessState(bool value) async {
    isPaymentUnderProcessing = value;
    notifyListeners();
  }

  Future<AddressData?> getSingleAddressProvider(
      {required BuildContext context}) async {
    try {
      Map<String, dynamic> getAddress = (await getAddressApi(
          context: context, params: {ApiAndParams.isDefault: "1"}));
      if (getAddress[ApiAndParams.status].toString() == "1") {
        Address addressData = Address.fromJson(getAddress);
        selectedAddress = addressData.data?[0];

        if (selectedAddress?.cityId?.toString() == "0") {
          checkoutAddressState = CheckoutAddressState.addressError;
          notifyListeners();
          selectedAddress = AddressData();
          return AddressData();
        } else {
          checkoutAddressState = CheckoutAddressState.addressLoaded;
          notifyListeners();
          return selectedAddress;
        }
      } else {
        checkoutAddressState = CheckoutAddressState.addressBlank;
        notifyListeners();
        return selectedAddress;
      }
    } catch (e) {
      message = e.toString();
      checkoutAddressState = CheckoutAddressState.addressError;
      notifyListeners();
      if (context.mounted) {
        GeneralMethods.showMessage(
          context,
          message,
          MessageType.warning,
        );
      }
      return selectedAddress;
    }
  }

  setSelectedAddress(BuildContext context, var address) async {
    if (address != AddressData()) {
      if (selectedAddress != AddressData()) {
        selectedAddress = address;

        checkoutAddressState = CheckoutAddressState.addressLoaded;
        notifyListeners();

        Map<String, String> params = {
          ApiAndParams.cityId: selectedAddress!.cityId.toString(),
          ApiAndParams.latitude: selectedAddress!.latitude.toString(),
          ApiAndParams.longitude: selectedAddress!.longitude.toString(),
          ApiAndParams.isCheckout: "1"
        };
        if (Constant.isPromoCodeApplied) {
          params[ApiAndParams.promoCodeId] = Constant.selectedPromoCodeId;
        }

        await getOrderChargesProvider(
          context: context,
          params: params,
        );
      }
    } else if (selectedAddress == null && address == null) {
      checkoutAddressState = CheckoutAddressState.addressBlank;
      notifyListeners();
    }
  }

  setAddressEmptyState() {
    selectedAddress = null;
    checkoutAddressState = CheckoutAddressState.addressLoaded;
    notifyListeners();
  }

  Future getOrderChargesProvider(
      {required BuildContext context,
      required Map<String, String> params}) async {
    try {
      checkoutDeliveryChargeState =
          CheckoutDeliveryChargeState.deliveryChargeLoading;
      notifyListeners();
      Map<String, dynamic> getCheckoutData =
          (await getCartListApi(context: context, params: params));

      if (getCheckoutData[ApiAndParams.status].toString() == "1") {
        Checkout checkoutData = Checkout.fromJson(getCheckoutData);
        deliveryChargeData = checkoutData.data!;
        isCodAllowed = deliveryChargeData?.codAllowed.toString() != "0";
        subTotalAmount = double.parse(deliveryChargeData?.subTotal ?? "0");
        totalAmount = double.parse(deliveryChargeData?.totalAmount ?? "0");
        deliveryCharge = double.parse(
            deliveryChargeData?.deliveryCharge?.totalDeliveryCharge ?? "0");
        sellerWiseDeliveryCharges =
            deliveryChargeData?.deliveryCharge!.sellersInfo!;

        checkoutDeliveryChargeState =
            CheckoutDeliveryChargeState.deliveryChargeLoaded;
        checkoutAddressState = CheckoutAddressState.addressLoaded;
        notifyListeners();
      } else {
        isCodAllowed = false;
        checkoutDeliveryChargeState =
            CheckoutDeliveryChargeState.deliveryChargeError;
        checkoutAddressState = CheckoutAddressState.addressBlank;
        notifyListeners();
      }
    } catch (e) {
      isCodAllowed = false;
      message = e.toString();
      checkoutDeliveryChargeState =
          CheckoutDeliveryChargeState.deliveryChargeError;
      checkoutAddressState = CheckoutAddressState.addressBlank;
      notifyListeners();
      if (context.mounted) {
        GeneralMethods.showMessage(
          context,
          message,
          MessageType.warning,
        );
      }
    }
  }

  Future getTimeSlotsSettings({required BuildContext context}) async {
    try {
      Map<String, dynamic> getTimeSlotsSettings =
          (await getTimeSlotSettingsApi(context: context, params: {}));

      if (getTimeSlotsSettings[ApiAndParams.status].toString() == "1") {
        TimeSlotsSettings timeSlots =
            TimeSlotsSettings.fromJson(getTimeSlotsSettings);
        timeSlotsData = timeSlots.data;
        isTimeSlotsEnabled = timeSlots.data.timeSlotsIsEnabled == "true";

        selectedDate = 0;
        // DateFormat dateFormat = DateFormat("yyyy-MM-d hh:mm:ss");
        // DateTime now = new DateTime.now();
        // DateTime currentTime = dateFormat.parse(
        //     "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}");
        //2022-10-18 11:36:14.267721
        if (int.parse(timeSlotsData?.timeSlotsDeliveryStartsFrom ?? "0") > 1) {
          selectedTime = 0;
        }
        /* else {
          for (int i = 0; i < timeSlotsData.timeSlots.length; i++) {
            DateTime timeSlotTime = dateFormat.parse(
                "${currentTime.year}-${currentTime.month}-${currentTime.day} ${timeSlotsData.timeSlots[i].lastOrderTime}");
          }
        }*/

        checkoutTimeSlotsState = CheckoutTimeSlotsState.timeSlotsLoaded;
        notifyListeners();
      } else {
        isTimeSlotsEnabled = false;
        if (context.mounted) {
          GeneralMethods.showMessage(
            context,
            message,
            MessageType.warning,
          );
        }
        checkoutTimeSlotsState = CheckoutTimeSlotsState.timeSlotsError;
        notifyListeners();
      }
    } catch (e) {
      isTimeSlotsEnabled = false;

      checkoutTimeSlotsState = CheckoutTimeSlotsState.timeSlotsError;
      notifyListeners();
    }
  }

  setSelectedDate(int index) {
    selectedTime = 0;
    selectedDate = index;
    // DateTime currentTime = DateTime.now();
    // DateFormat dateFormat = DateFormat("yyyy-MM-d hh:mm:ss");
    //2022-10-18 11:36:14.267721
    if (int.parse(timeSlotsData?.timeSlotsDeliveryStartsFrom ?? "0") > 1) {
      selectedTime = 0;
    }
    /* else {
      for (int i = 0; i < timeSlotsData.timeSlots.length; i++) {
        DateTime timeSlotTime = dateFormat.parse(
            "${currentTime.year}-${currentTime.month}-${currentTime.day} ${timeSlotsData.timeSlots[i].lastOrderTime}");
      }
    }*/
    notifyListeners();
  }

  setSelectedTime(int index) {
    selectedTime = index;
    notifyListeners();
  }

  Future getPaymentMethods({required BuildContext context}) async {
    try {
      Map<String, dynamic> getPaymentMethodsSettings =
          (await getPaymentMethodsSettingsApi(context: context, params: {}));

      if (getPaymentMethodsSettings[ApiAndParams.status].toString() == "1") {
        List<int> decodedBytes = base64
            .decode(getPaymentMethodsSettings[ApiAndParams.data].toString());
        String decodedString = utf8.decode(decodedBytes);
        Map<String, dynamic> map = json.decode(decodedString);
        getPaymentMethodsSettings[ApiAndParams.data] = map;

        paymentMethods = PaymentMethods.fromJson(getPaymentMethodsSettings);
        paymentMethodsData = paymentMethods?.data;

        if (isCodAllowed ?? true) {
          isCodAllowed = true;
        } else {
          isCodAllowed = false;
        }

        if (paymentMethodsData?.codPaymentMethod == "1" &&
            isCodAllowed == true) {
          selectedPaymentMethod = "COD";
        } else if (paymentMethodsData?.razorpayPaymentMethod == "1") {
          selectedPaymentMethod = "Razorpay";
        } else if (paymentMethodsData?.paystackPaymentMethod == "1") {
          selectedPaymentMethod = "Paystack";
        } else if (paymentMethodsData?.stripePaymentMethod == "1") {
          selectedPaymentMethod = "Stripe";
        } else if (paymentMethodsData?.paytmPaymentMethod == "1") {
          selectedPaymentMethod = "Paytm";
        } else if (paymentMethodsData?.paypalPaymentMethod == "1") {
          selectedPaymentMethod = "Paypal";
        }

        checkoutPaymentMethodsState =
            CheckoutPaymentMethodsState.paymentMethodLoaded;
        notifyListeners();
      } else {
        if (context.mounted) {
          GeneralMethods.showMessage(
            context,
            message,
            MessageType.warning,
          );
        }
        checkoutPaymentMethodsState =
            CheckoutPaymentMethodsState.paymentMethodError;
        notifyListeners();
      }
    } catch (e) {
      message = e.toString();
      if (context.mounted) {
        GeneralMethods.showMessage(
          context,
          message,
          MessageType.warning,
        );
      }
      checkoutPaymentMethodsState =
          CheckoutPaymentMethodsState.paymentMethodError;
      notifyListeners();
    }
  }

  setSelectedPaymentMethod(String method) {
    selectedPaymentMethod = method;
    notifyListeners();
  }

  Future placeOrder({required BuildContext context}) async {
    try {
      context.read<CheckoutProvider>().isPaymentUnderProcessing = true;
      DateTime dateTime;
      if (int.parse(
              timeSlotsData?.timeSlotsDeliveryStartsFrom.toString() ?? "0") ==
          1) {
        dateTime = DateTime.now();
      } else {
        dateTime = DateTime.now().add(Duration(
            days: int.parse(timeSlotsData?.timeSlotsAllowedDays ?? "0")));
      }
      final orderStatus = selectedPaymentMethod == "COD" ? "2" : "1";

      Map<String, String> params = {};
      params[ApiAndParams.productVariantId] =
          deliveryChargeData?.productVariantId.toString() ?? "0";
      params[ApiAndParams.quantity] =
          deliveryChargeData?.quantity.toString() ?? "0";
      params[ApiAndParams.total] =
          deliveryChargeData?.subTotal.toString() ?? "0";
      params[ApiAndParams.deliveryCharge] =
          deliveryChargeData?.deliveryCharge?.totalDeliveryCharge ?? "0";
      params[ApiAndParams.finalTotal] =
          deliveryChargeData?.totalAmount.toString() ?? "0";
      params[ApiAndParams.paymentMethod] = selectedPaymentMethod.toString();
      params[ApiAndParams.addressId] = selectedAddress!.id.toString();
      params[ApiAndParams.deliveryTime] =
          "${dateTime.day}-${dateTime.month}-${dateTime.year} ${timeSlotsData?.timeSlots[selectedTime].title}";
      params[ApiAndParams.status] = orderStatus;
      if (Constant.isPromoCodeApplied) {
        params[ApiAndParams.promoCodeId] = Constant.selectedPromoCodeId;
      }

      Map<String, dynamic> getPlaceOrderResponse =
          (await getPlaceOrderApi(context: context, params: params));
      if (getPlaceOrderResponse[ApiAndParams.status].toString() == "1") {
        if (selectedPaymentMethod != "COD") {
          PlacedPrePaidOrder placedPrePaidOrder =
              PlacedPrePaidOrder.fromJson(getPlaceOrderResponse);
          placedOrderId = placedPrePaidOrder.data.orderId.toString();
        }

        if (selectedPaymentMethod == "Razorpay" ||
            selectedPaymentMethod == "Stripe") {
        } else if (selectedPaymentMethod == "Paystack") {
          payStackReference =
              "Charged_From_${GeneralMethods.setFirstLetterUppercase(Platform.operatingSystem)}_${DateTime.now().millisecondsSinceEpoch}";
          transactionId = payStackReference;
        } else if (selectedPaymentMethod == "COD") {
          if (context.mounted) showOrderPlacedScreen(context);
        } else if (selectedPaymentMethod == "Paytm") {
          if (context.mounted) {
            initiatePaytmTransaction(context: context).then((value) {
              return value;
            });
          }
        } else if (selectedPaymentMethod == "Paypal") {
          if (context.mounted) {
            initiatePaypalTransaction(context: context).then((value) {
              return value;
            });
          }
        }

        checkoutPlaceOrderState = CheckoutPlaceOrderState.placeOrderLoaded;
        notifyListeners();
        return true;
      } else {
        if (context.mounted) {
          GeneralMethods.showMessage(
            context,
            getPlaceOrderResponse[ApiAndParams.message],
            MessageType.warning,
          );
        }
        checkoutPlaceOrderState = CheckoutPlaceOrderState.placeOrderError;
        notifyListeners();
        return false;
      }
    } catch (e) {
      message = e.toString();
      if (context.mounted) {
        GeneralMethods.showMessage(
          context,
          message,
          MessageType.warning,
        );
      }
      checkoutPlaceOrderState = CheckoutPlaceOrderState.placeOrderError;
      notifyListeners();
      return false;
    }
  }

  Future initiatePaytmTransaction({required BuildContext context}) async {
    try {
      Map<String, String> params = {};

      params[ApiAndParams.orderId] = placedOrderId;
      params[ApiAndParams.amount] = totalAmount.toString();

      Map<String, dynamic> getPaytmTransactionTokenResponse =
          (await getPaytmTransactionTokenApi(context: context, params: params));

      if (getPaytmTransactionTokenResponse[ApiAndParams.status].toString() ==
          "1") {
        PaytmTransactionToken paytmTransactionToken =
            PaytmTransactionToken.fromJson(getPaytmTransactionTokenResponse);
        paytmTxnToken = paytmTransactionToken.data?.txnToken ?? "";
        checkoutPlaceOrderState = CheckoutPlaceOrderState.placeOrderLoaded;
        notifyListeners();
      } else {
        if (context.mounted) {
          GeneralMethods.showMessage(
            context,
            message,
            MessageType.warning,
          );
        }
        checkoutPlaceOrderState = CheckoutPlaceOrderState.placeOrderError;
        notifyListeners();
        return false;
      }
    } catch (e) {
      message = e.toString();
      if (context.mounted) {
        GeneralMethods.showMessage(
          context,
          message,
          MessageType.warning,
        );
      }
      checkoutPlaceOrderState = CheckoutPlaceOrderState.placeOrderError;
      notifyListeners();
      return false;
    }
  }

  Future initiateRazorpayTransaction({required BuildContext context}) async {
    try {
      Map<String, String> params = {};

      params[ApiAndParams.paymentMethod] = selectedPaymentMethod.toString();
      params[ApiAndParams.orderId] = placedOrderId;

      Map<String, dynamic> getInitiatedTransactionResponse =
          (await getInitiatedTransactionApi(context: context, params: params));

      if (getInitiatedTransactionResponse[ApiAndParams.status].toString() ==
          "1") {
        InitiateTransaction initiateTransaction =
            InitiateTransaction.fromJson(getInitiatedTransactionResponse);
        razorpayOrderId = initiateTransaction.data.transactionId;
        checkoutPlaceOrderState = CheckoutPlaceOrderState.placeOrderLoaded;
        notifyListeners();
      } else {
        if (context.mounted) {
          GeneralMethods.showMessage(
            context,
            message,
            MessageType.warning,
          );
        }
        checkoutPlaceOrderState = CheckoutPlaceOrderState.placeOrderError;
        notifyListeners();
      }
    } catch (e) {
      message = e.toString();
      if (context.mounted) {
        GeneralMethods.showMessage(
          context,
          message,
          MessageType.warning,
        );
      }
      checkoutPlaceOrderState = CheckoutPlaceOrderState.placeOrderError;
      notifyListeners();
    }
  }

  showOrderPlacedScreen(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushNamed(context, orderPlaceScreen);
  }

  Future initiatePaypalTransaction({required BuildContext context}) async {
    try {
      Map<String, String> params = {};

      params[ApiAndParams.paymentMethod] = selectedPaymentMethod.toString();
      params[ApiAndParams.orderId] = placedOrderId;

      Map<String, dynamic> getInitiatedTransactionResponse =
          (await getInitiatedTransactionApi(context: context, params: params));

      if (getInitiatedTransactionResponse[ApiAndParams.status].toString() ==
          "1") {
        Map<String, dynamic> data =
            getInitiatedTransactionResponse[ApiAndParams.data];
        if (context.mounted) {
          Navigator.pushNamed(context, paypalPaymentScreen,
                  arguments: data["paypal_redirect_url"])
              .then((value) {
            if (value == true) {
              showOrderPlacedScreen(context);
            } else {
              context.read<CheckoutProvider>().deleteAwaitingOrder(context);
              GeneralMethods.showMessage(
                context,
                getTranslatedValue(context, "payment_cancelled_by_user"),
                MessageType.warning,
              );
              return false;
            }
          });
        }
        checkoutPlaceOrderState = CheckoutPlaceOrderState.placeOrderLoaded;
        notifyListeners();
      } else {
        if (context.mounted) {
          GeneralMethods.showMessage(
            context,
            message,
            MessageType.warning,
          );
        }
        checkoutPlaceOrderState = CheckoutPlaceOrderState.placeOrderError;
        notifyListeners();
      }
    } catch (e) {
      message = e.toString();
      if (context.mounted) {
        GeneralMethods.showMessage(
          context,
          message,
          MessageType.warning,
        );
      }
      checkoutPlaceOrderState = CheckoutPlaceOrderState.placeOrderError;
      notifyListeners();
    }
  }

  Future addTransaction({required BuildContext context}) async {
    try {
      PackageInfo packageInfo;
      packageInfo = await PackageInfo.fromPlatform();

      Map<String, String> params = {};

      params[ApiAndParams.orderId] = placedOrderId;
      params[ApiAndParams.deviceType] =
          GeneralMethods.setFirstLetterUppercase(Platform.operatingSystem);
      params[ApiAndParams.appVersion] = packageInfo.version;
      params[ApiAndParams.transactionId] = transactionId;
      params[ApiAndParams.paymentMethod] = selectedPaymentMethod.toString();
      if (context.mounted) {
        Map<String, dynamic> addedTransaction =
            (await getAddTransactionApi(context: context, params: params));
        if (addedTransaction[ApiAndParams.status].toString() == "1") {
          checkoutPlaceOrderState = CheckoutPlaceOrderState.placeOrderLoaded;
          notifyListeners();
          if (context.mounted) showOrderPlacedScreen(context);
        } else {
          if (context.mounted) {
            GeneralMethods.showMessage(
              context,
              addedTransaction[ApiAndParams.message],
              MessageType.warning,
            );
          }
          checkoutPlaceOrderState = CheckoutPlaceOrderState.placeOrderError;
          notifyListeners();
        }
      }
    } catch (e) {
      message = e.toString();
      if (context.mounted) {
        GeneralMethods.showMessage(
          context,
          message,
          MessageType.warning,
        );
      }
      checkoutPlaceOrderState = CheckoutPlaceOrderState.placeOrderError;
      notifyListeners();
    }
  }

  Future deleteAwaitingOrder(BuildContext context) async {
    try {
      await deleteAwaitingOrderApi(
          params: {ApiAndParams.orderId: placedOrderId}, context: context);
    } catch (e) {
      if (context.mounted) {
        GeneralMethods.showMessage(context, e.toString(), MessageType.error);
      }
    }
  }
}
