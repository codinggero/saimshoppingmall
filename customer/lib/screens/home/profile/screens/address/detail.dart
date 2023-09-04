import 'package:flutter/material.dart';

import '../../../../../helper/utils/export.dart';

class AddressDetailScreen extends StatefulWidget {
  final AddressData? address;
  final BuildContext addressProviderContext;

  const AddressDetailScreen({
    Key? key,
    this.address,
    required this.addressProviderContext,
  }) : super(key: key);

  @override
  State<AddressDetailScreen> createState() => _AddressDetailScreenState();
}

class _AddressDetailScreenState extends State<AddressDetailScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController edtName = TextEditingController();
  final TextEditingController edtMobile = TextEditingController();
  final TextEditingController edtAltMobile = TextEditingController();
  final TextEditingController edtAddress = TextEditingController();
  final TextEditingController edtLandmark = TextEditingController();
  final TextEditingController edtCity = TextEditingController();
  final TextEditingController edtArea = TextEditingController();
  final TextEditingController edtZipcode = TextEditingController();
  final TextEditingController edtCountry = TextEditingController();
  final TextEditingController edtState = TextEditingController();
  bool isLoading = false;
  bool isDefaultAddress = false;
  String longitude = "";
  String latitude = "";

  //Address types
  String selectedType = "home";
  static Map addressTypes = {};

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        addressTypes = {
          "home": getTranslatedValue(
            context,
            "address_type_home",
          ),
          "office": getTranslatedValue(
            context,
            "address_type_office",
          ),
          "other": getTranslatedValue(
            context,
            "address_type_other",
          ),
        };
        edtName.text = widget.address?.name ?? "";
        edtAltMobile.text = widget.address?.alternateMobile ?? "";
        edtMobile.text = widget.address?.mobile ?? "";
        edtAddress.text = widget.address?.address ?? "";
        edtLandmark.text = widget.address?.landmark ?? "";
        edtCity.text = widget.address?.city ?? "";
        edtArea.text = widget.address?.area ?? "";
        edtZipcode.text = widget.address?.pincode ?? "";
        edtCountry.text = widget.address?.country ?? "";
        edtState.text = widget.address?.state ?? "";
        selectedType = widget.address?.type?.toLowerCase() ??
            getTranslatedValue(
              context,
              "address_type_home",
            );
        longitude = widget.address?.longitude ?? "";
        latitude = widget.address?.latitude ?? "";
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(
            context: context,
            title: CustomTextLabel(
              jsonKey: "address_detail",
              style: TextStyle(color: ColorsRes.mainTextColor),
            )),
        body: Stack(
          children: [
            ListView(
                padding: EdgeInsets.symmetric(
                    horizontal: Constant.size10, vertical: Constant.size10),
                children: [
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          contactWidget(),
                          addressDetailWidget(),
                        ],
                      )),
                  addressTypeWidget()
                ]),
            isLoading == true
                ? PositionedDirectional(
                    top: 0,
                    end: 0,
                    start: 0,
                    bottom: 0,
                    child: Container(
                        color: Colors.black.withOpacity(0.2),
                        child:
                            const Center(child: CircularProgressIndicator())),
                  )
                : const SizedBox.shrink()
          ],
        ));
  }

  contactWidget() {
    return Card(
      shape: DesignConfig.setRoundedBorder(8),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Constant.size10, vertical: Constant.size10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextLabel(
              jsonKey: "contact_details",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: ColorsRes.mainTextColor,
              ),
            ),
            const Divider(
              height: 15,
            ),
            editBoxWidget(
              context,
              edtName,
              GeneralMethods.emptyValidation,
              getTranslatedValue(
                context,
                "name",
              ),
              getTranslatedValue(
                context,
                "enter_name",
              ),
              TextInputType.text,
            ),
            SizedBox(height: Constant.size15),
            editBoxWidget(
              context,
              edtMobile,
              GeneralMethods.phoneValidation,
              getTranslatedValue(
                context,
                "mobile_number",
              ),
              getTranslatedValue(
                context,
                "enter_valid_mobile",
              ),
              TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            SizedBox(height: Constant.size15),
            editBoxWidget(
              context,
              edtAltMobile,
              GeneralMethods.phoneValidation,
              getTranslatedValue(
                context,
                "alternate_mobile_number",
              ),
              getTranslatedValue(
                context,
                "enter_valid_mobile",
              ),
              TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ],
        ),
      ),
    );
  }

  addressDetailWidget() {
    return Card(
      shape: DesignConfig.setRoundedBorder(8),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Constant.size10, vertical: Constant.size10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextLabel(
              jsonKey: "address_details",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: ColorsRes.mainTextColor,
              ),
            ),
            const Divider(
              height: 15,
            ),
            editBoxWidget(
                context,
                edtAddress,
                GeneralMethods.emptyValidation,
                getTranslatedValue(
                  context,
                  "address",
                ),
                getTranslatedValue(
                  context,
                  "enter_address",
                ),
                TextInputType.text,
                tailIcon: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, getLocationScreen,
                            arguments: "address")
                        .then(
                      (value) {
                        setState(
                          () {
                            edtAddress.text =
                                Constant.cityAddressMap["address"];
                            edtCity.text = Constant.cityAddressMap["city"];
                            edtArea.text = Constant.cityAddressMap["area"];
                            edtLandmark.text =
                                Constant.cityAddressMap["landmark"];
                            edtZipcode.text =
                                Constant.cityAddressMap["pin_code"];
                            edtCountry.text =
                                Constant.cityAddressMap["country"];
                            edtState.text = Constant.cityAddressMap["state"];
                            longitude =
                                Constant.cityAddressMap["longitude"].toString();
                            latitude =
                                Constant.cityAddressMap["latitude"].toString();
                          },
                        );
                        formKey.currentState?.validate();
                      },
                    );
                  },
                  icon: Icon(
                    Icons.my_location_rounded,
                    color: ColorsRes.appColor,
                  ),
                )),
            SizedBox(height: Constant.size15),
            editBoxWidget(
                context,
                edtLandmark,
                GeneralMethods.emptyValidation,
                getTranslatedValue(
                  context,
                  "landmark",
                ),
                getTranslatedValue(
                  context,
                  "enter_landmark",
                ),
                TextInputType.text),
            SizedBox(height: Constant.size15),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, getLocationScreen,
                        arguments: "address")
                    .then(
                  (value) {
                    setState(
                      () {
                        edtAddress.text = Constant.cityAddressMap["address"];
                        edtCity.text = Constant.cityAddressMap["city"];
                        edtArea.text = Constant.cityAddressMap["area"];
                        edtLandmark.text = Constant.cityAddressMap["landmark"];
                        edtZipcode.text = Constant.cityAddressMap["pin_code"];
                        edtCountry.text = Constant.cityAddressMap["country"];
                        edtState.text = Constant.cityAddressMap["state"];
                        longitude =
                            Constant.cityAddressMap["longitude"].toString();
                        latitude =
                            Constant.cityAddressMap["latitude"].toString();
                        formKey.currentState?.validate();
                      },
                    );
                  },
                );
              },
              child: editBoxWidget(
                  context,
                  edtCity,
                  GeneralMethods.emptyValidation,
                  getTranslatedValue(
                    context,
                    "city",
                  ),
                  getTranslatedValue(
                    context,
                    "please_select_address_from_map",
                  ),
                  TextInputType.text,
                  isEditable: false),
            ),
            SizedBox(height: Constant.size15),
            editBoxWidget(
              context,
              edtArea,
              GeneralMethods.emptyValidation,
              getTranslatedValue(
                context,
                "area",
              ),
              getTranslatedValue(
                context,
                "enter_area",
              ),
              TextInputType.text,
            ),
            SizedBox(height: Constant.size15),
            editBoxWidget(
              context,
              edtZipcode,
              GeneralMethods.emptyValidation,
              getTranslatedValue(
                context,
                "pin_code",
              ),
              getTranslatedValue(
                context,
                "enter_pin_code",
              ),
              TextInputType.text,
            ),
            SizedBox(height: Constant.size15),
            editBoxWidget(
              context,
              edtState,
              GeneralMethods.emptyValidation,
              getTranslatedValue(
                context,
                "state",
              ),
              getTranslatedValue(
                context,
                "enter_state",
              ),
              TextInputType.text,
            ),
            SizedBox(height: Constant.size15),
            editBoxWidget(
              context,
              edtCountry,
              GeneralMethods.emptyValidation,
              getTranslatedValue(
                context,
                "country",
              ),
              getTranslatedValue(
                context,
                "enter_country",
              ),
              TextInputType.text,
            ),
          ],
        ),
      ),
    );
  }

  addressTypeWidget() {
    return Card(
      shape: DesignConfig.setRoundedBorder(8),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Constant.size10,
          vertical: Constant.size10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextLabel(
              jsonKey: "address_type",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: ColorsRes.mainTextColor,
              ),
            ),
            const Divider(
              height: 15,
            ),
            SizedBox(height: Constant.size10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                addressTypes.length,
                (index) {
                  String key = addressTypes.keys.elementAt(index);
                  String value = addressTypes[key];
                  return GestureDetector(
                    onTap: () {
                      if (selectedType != key) {
                        setState(
                          () {
                            selectedType = key;
                          },
                        );
                      }
                    },
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      color: selectedType == key
                          ? ColorsRes.appColor
                          : ColorsRes.grey.withOpacity(
                              0.3,
                            ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Constant.size25,
                          vertical: Constant.size10,
                        ),
                        child: CustomTextLabel(
                          text: value,
                          style: TextStyle(
                            color: selectedType == key
                                ? ColorsRes.appColorWhite
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: Constant.size10),
            CheckboxListTile(
              value: isDefaultAddress,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              activeColor: ColorsRes.appColor,
              title: const CustomTextLabel(
                jsonKey: "set_as_default_address",
              ),
              onChanged: (bool? isChecked) {
                setState(
                  () {
                    isDefaultAddress = isChecked!;
                  },
                );
              },
            ),
            SizedBox(height: Constant.size10),
            Widgets.gradientBtnWidget(
              context,
              8,
              title: (widget.address?.id.toString() ?? "").isNotEmpty
                  ? getTranslatedValue(
                      context,
                      "update",
                    )
                  : getTranslatedValue(
                      context,
                      "add_new_address",
                    ),
              callback: () async {
                if (formKey.currentState!.validate() == true) {
                  if (longitude.isNotEmpty && latitude.isNotEmpty) {
                    Map<String, String> params = {};

                    String id = widget.address?.id.toString() ?? "";
                    if (id.isNotEmpty) {
                      params[ApiAndParams.id] = id;
                    }

                    params[ApiAndParams.name] = edtName.text.trim().toString();
                    params[ApiAndParams.mobile] =
                        edtMobile.text.trim().toString();
                    params[ApiAndParams.type] = selectedType;
                    params[ApiAndParams.address] =
                        edtAddress.text.trim().toString();
                    params[ApiAndParams.landmark] =
                        edtLandmark.text.trim().toString();
                    params[ApiAndParams.area] = edtArea.text.trim().toString();
                    params[ApiAndParams.pinCode] =
                        edtZipcode.text.trim().toString();
                    params[ApiAndParams.city] = edtCity.text.trim().toString();
                    params[ApiAndParams.state] =
                        edtState.text.trim().toString();
                    params[ApiAndParams.country] =
                        edtCountry.text.trim().toString();
                    params[ApiAndParams.alternateMobile] =
                        edtAltMobile.text.trim().toString();
                    params[ApiAndParams.latitude] = latitude;
                    params[ApiAndParams.longitude] = longitude;
                    params[ApiAndParams.isDefault] =
                        isDefaultAddress == true ? "1" : "0";

                    widget.addressProviderContext
                        .read<AddressProvider>()
                        .addOrUpdateAddress(
                            context: context,
                            address: widget.address ?? "",
                            params: params,
                            function: () {
                              Navigator.pop(context);
                            });
                    setState(() {
                      isLoading = !isLoading;
                    });
                  } else {
                    setState(() {
                      isLoading = !isLoading;
                    });
                    GeneralMethods.showMessage(
                      context,
                      getTranslatedValue(
                        context,
                        "please_select_address_from_map",
                      ),
                      MessageType.warning,
                    );
                  }
                }
              },
            ),
            SizedBox(height: Constant.size10),
          ],
        ),
      ),
    );
  }
}
