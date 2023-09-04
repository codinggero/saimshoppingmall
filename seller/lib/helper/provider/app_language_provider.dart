import 'package:flutter/material.dart';
import '../utils/export.dart';

enum LanguageState {
  initial,
  loading,
  updating,
  loaded,
  error,
}

class LanguageProvider extends ChangeNotifier {
  LanguageState languageState = LanguageState.initial;
  String code = 'en';

  LanguageProvider() {
    init();
  }

  void init() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      Requests.get().then((value) {
        console.log({'currentLanguage': value});
        currentLanguage = value;
        notifyListeners();
      });
    });
  }

  LanguageJsonData? jsonData;
  Map<dynamic, dynamic> currentLanguage = {
    "en": {
      "login_type_page_title": "Welcome",
      "login_type_page_description":
          "Grocery App Description \nA grocery delivery application is an app that allows users to order their groceries online. The app owners are responsible for facilitating the grocery delivery to users' homes according to their terms and conditions.",
      "login_as": "Login As",
      "seller": "Seller",
      "delivery_boy": "Delivery Boy",
      "login": "Login",
      "email": "Email",
      "agreement_message_1":
          "By clicking here, I state that I have read and understood the",
      "terms_of_service": "Terms Of Service",
      "and": "And",
      "privacy_policy": "Privacy Policy",
      "password": "Password",
      "register": "Register",
      "accept_terms_condition_message": "Accept Te1rms Condition Message",
      "user_name": "Username",
      "mobile": "Mobile",
      "confirm_password": "Confirm Password",
      "enter_valid": "Enter Valid",
      "home_bottom_menu_home": "Home",
      "home_bottom_menu_profile": "Profile",
      "change_theme": "Change Theme",
      "change_language": "Change Language",
      "order_status_display_names_shipped": "Shipped",
      "order_status_display_names_out_for_delivery": "Pending Delivery",
      "order_status_display_names_delivered": "Delivery",
      "order_status_display_names_returned": "Returned",
      "orders": "Orders",
      "balance": "Balance",
      "order_status_display_names_cancelled": "Cancelled",
      "settings": "Settings",
      "rate_us": "Rate Us",
      "logout": "Logout",
      "title_profile": "Profile",
      "order_status_display_names_all": "All",
      "order_status_display_names_awaiting": "Awaiting",
      "order_status_display_names_received": "Received",
      "order_status_display_names_processed": "Processed",
      "next": "Next",
      "date_of_birth": "Date Of Birth",
      "personal_information": "Personal Information",
      "national_identification_card": "National Identification Card",
      "address_proof": "Address Proof",
      "select_city": "City",
      "theme_display_names_system_default": "Default",
      "theme_display_names_light": "Light",
      "theme_display_names_dark": "Dark",
      "update_settings": "Update Settings",
      "notifications_settings": "Notifications Settings",
      "logout_title": "Logout",
      "logout_message": "Are You Sure?",
      "cancel": "Cancel",
      "ok": "Ok",
      "select_location": "Select Location",
      "select_delivery_location": "Select Delivery Location",
      "use_my_current_location": "Use My Current Location",
      "or": "Or",
      "type_location_manually": "Type Location Manually",
      "confirm_location": "Confirm Location",
      "select_your_location": "Select Your Location",
      "does_not_delivery_long_message": "Does Not Delivery Long Message",
      "change": "Change",
      "recent_searches": "Recent Searches",
      "previous": "Previous",
      "save": "Save",
      "bank_information": "Bank Information",
      "bank_name": "Bank Name",
      "account_number": "Account Number",
      "ifsc_code": "IFSC Code",
      "account_name": "account Name",
      "home_bottom_menu_orders": "Orders",
      "home_bottom_menu_category": "Category",
      "title_categories": "Categories",
      "products": "Products",
      "sold_out_products": "Sold Out Products",
      "low_stock_products": "Low Stock Products",
      "daily_sales": "Daily Sales",
      "title_product_wise_category_count": "Category Count"
    },
    "ur": {
      "login_type_page_title": "خوش آمدید",
      "login_type_page_description":
          "گروسری ایپ کی تفصیل \n گروسری ڈیلیوری ایپلی کیشن ایک ایسی ایپ ہے جو صارفین کو اپنا گروسری آن لائن آرڈر کرنے کی اجازت دیتی ہے۔ ایپ کے مالکان ان کی شرائط و ضوابط کے مطابق صارفین کے گھروں تک گروسری کی ترسیل کی سہولت فراہم کرنے کے ذمہ دار ہیں۔",
      "login_as": "بطور سائن ان کریں۔",
      "seller": "بیچنے والے",
      "delivery_boy": "ڈیلیوری بوائے",
      "login": "لاگ ان کریں",
      "email": "ای میل",
      "agreement_message_1":
          "یہاں کلک کرکے، میں بیان کرتا ہوں کہ میں نے پڑھ اور سمجھ لیا ہے۔",
      "terms_of_service": "سروس کی شرائط",
      "and": "اور",
      "privacy_policy": "رازداری کی پالیسی",
      "password": "پاس ورڈ",
      "register": "Register",
      "accept_terms_condition_message": "شرائط کا پیغام قبول کریں۔",
      "user_name": "صارف نام",
      "mobile": "موبائل",
      "confirm_password": "پاس ورڈ کی تصدیق کریں۔",
      "enter_valid": "درست درج کریں۔",
      "home_bottom_menu_home": "گھر",
      "home_bottom_menu_profile": "پروفائل",
      "change_theme": "تھیم تبدیل کریں۔",
      "change_language": "زبان تبدیل کریں",
      "order_status_display_names_shipped": "بھیج دیا گیا۔",
      "order_status_display_names_out_for_delivery": "زیر التواء ترسیل",
      "order_status_display_names_delivered": "ترسیل",
      "order_status_display_names_returned": "واپس آ گیا۔",
      "orders": "احکامات",
      "balance": "بقیہ",
      "order_status_display_names_cancelled": "منسوخ",
      "settings": "ترتیبات",
      "rate_us": "ہمیں درجہ دیں۔",
      "logout": "لاگ آوٹ",
      "title_profile": "پروفائل",
      "order_status_display_names_all": "تمام",
      "order_status_display_names_awaiting": "انتظار کر رہا ہے۔",
      "order_status_display_names_received": "موصول ہوا۔",
      "order_status_display_names_processed": "پروسیس شدہ",
      "next": "اگلے",
      "date_of_birth": "پیدائش کی تاریخ",
      "personal_information": "ذاتی معلومات",
      "national_identification_card": "قومی شناختی کارڈS",
      "address_proof": "ایڈریس پروف",
      "select_city": "شہر",
      "theme_display_names_system_default": "طے شدہ",
      "theme_display_names_light": "روشنی",
      "theme_display_names_dark": "اندھیرا",
      "update_settings": "اپ ڈیٹ سیٹنگز",
      "notifications_settings": "اطلاعات کی ترتیبات",
      "logout_title": "لاگ آوٹ",
      "logout_message": "کیا تمہیں یقین ہے؟",
      "cancel": "منسوخ کریں۔",
      "ok": "ٹھیک ہے",
      "select_location": "مقام منتخب کریں۔",
      "select_delivery_location": "ڈیلیوری کا مقام منتخب کریں۔",
      "use_my_current_location": "میرا موجودہ مقام استعمال کریں۔",
      "or": "یا",
      "type_location_manually": "دستی طور پر مقام ٹائپ کریں۔",
      "confirm_location": "مقام کی تصدیق کریں۔",
      "select_your_location": "اپنا مقام منتخب کریں۔",
      "does_not_delivery_long_message": "طویل پیغام کی ترسیل نہیں کرتا",
      "change": "تبدیلی",
      "recent_searches": "حالیہ تلاشیں۔",
      "previous": "پچھلا",
      "save": "محفوظ کریں۔",
      "bank_information": "بینک کی معلومات",
      "bank_name": "بینک کا نام",
      "account_number": "اکاؤنٹ نمبر",
      "ifsc_code": "IFSC کوڈ",
      "account_name": "کھاتے کا نام",
      "home_bottom_menu_orders": "احکامات",
      "home_bottom_menu_category": "قسم",
      "title_categories": "اقسام",
      "products": "مصنوعات",
      "sold_out_products": "فروخت شدہ مصنوعات",
      "low_stock_products": "کم اسٹاک مصنوعات",
      "daily_sales": "ڈیلی سیلز",
      "title_product_wise_category_count": "زمرہ شمار"
    }
  };

  String languageDirection = 'ltr';
  TextDirection get textDirection {
    if (languageDirection == 'ltr') {
      return TextDirection.ltr;
    } else {
      return TextDirection.rtl;
    }
  }

  List<LanguageListData> languages = [];
  LanguageList? languageList;
  String selectedLanguage = "0";

  Future getLanguageDataProvider({
    required Map<String, dynamic> params,
    required BuildContext context,
  }) async {
    languageState = LanguageState.updating;
    notifyListeners();

    try {
      Map<String, dynamic> getData =
          (await getSystemLanguageApi(context: context, params: params));

      if (getData[ApiAndParams.status].toString() == "1") {
        jsonData = LanguageJsonData.fromJson(getData);
        languageDirection = jsonData!.data!.type!;

        currentLanguage = jsonData!.data!.jsonData!;
        Constant.session.setData(
          SessionManager.keySelectedLanguageId,
          jsonData!.data!.id!.toString(),
          false,
        );

        languageState = LanguageState.loaded;
        notifyListeners();
        return true;
      } else {
        languageState = LanguageState.error;
        notifyListeners();
        return null;
      }
    } catch (e) {
      languageState = LanguageState.error;
      if (context.mounted) {
        GeneralMethods.showSnackBarMsg(
          context,
          e.toString(),
        );
      }
      notifyListeners();
      return null;
    }
  }

  getAvailableLanguageList({
    required Map<String, dynamic> params,
    required BuildContext context,
  }) async {
    languageState = LanguageState.loading;
    notifyListeners();

    try {
      Map<String, dynamic> getData =
          (await getAvailableLanguagesApi(context: context, params: params));

      if (getData[ApiAndParams.status].toString() == "1") {
        languageList = LanguageList.fromJson(getData);
        languages = languageList!.data!;
      }

      languageState = LanguageState.loaded;
      notifyListeners();
    } catch (e) {
      languageState = LanguageState.error;
      notifyListeners();
    }
  }

  setSelectedLanguage(String index) {
    selectedLanguage = index;
    notifyListeners();
  }
}
