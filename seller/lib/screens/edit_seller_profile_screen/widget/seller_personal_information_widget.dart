import 'package:flutter/material.dart';
import '../../../helper/utils/export.dart';

class SellerPersonalInformationWidget extends StatefulWidget {
  final Map<String, String> personalData;
  final Map<String, String> personalDataFile;

  const SellerPersonalInformationWidget(
      {Key? key, required this.personalData, required this.personalDataFile})
      : super(key: key);

  @override
  State<SellerPersonalInformationWidget> createState() =>
      SellerPersonalInformationWidgetState();
}

class SellerPersonalInformationWidgetState
    extends State<SellerPersonalInformationWidget> {
  late TextEditingController edtUsername,
      edtEmail,
      edtMobile,
      edtPanNumber,
      edtNationalIdentityCardFilePath,
      edtAddressProofFilePath;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    edtUsername = TextEditingController(
      text: widget.personalData[ApiAndParams.name] ??
          Constant.session.getData(SessionManager.name),
    );
    edtEmail = TextEditingController(
      text: widget.personalData[ApiAndParams.email] ??
          Constant.session.getData(SessionManager.email),
    );
    edtMobile = TextEditingController(
      text: widget.personalData[ApiAndParams.mobile] ??
          Constant.session.getData(SessionManager.mobile),
    );
    edtPanNumber = TextEditingController(
      text: widget.personalData[ApiAndParams.pan_number] ??
          Constant.session.getData(SessionManager.pan_number),
    );
    edtNationalIdentityCardFilePath = TextEditingController(
      text: widget.personalDataFile[ApiAndParams.national_id_card] ??
          Constant.session.getData(SessionManager.national_identity_card_url),
    );
    edtAddressProofFilePath = TextEditingController(
      text: widget.personalDataFile[ApiAndParams.address_proof] ??
          Constant.session.getData(SessionManager.address_proof_url),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsetsDirectional.all(15),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslatedValue(context, "personal_information"),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
              const Divider(
                height: 15,
              ),
              editBoxWidget(
                context: context,
                edtController: edtUsername,
                validationFunction: GeneralMethods.emptyValidation,
                label: getTranslatedValue(context, "user_name"),
                inputType: TextInputType.text,
              ),
              Widgets.getSizedBox(
                height: 10,
              ),
              editBoxWidget(
                context: context,
                edtController: edtEmail,
                validationFunction: GeneralMethods.emailValidation,
                label: getTranslatedValue(context, "email"),
                isEditable: false,
                inputType: TextInputType.emailAddress,
              ),
              Widgets.getSizedBox(
                height: 10,
              ),
              editBoxWidget(
                context: context,
                edtController: edtMobile,
                validationFunction: GeneralMethods.emptyValidation,
                label: getTranslatedValue(context, "mobile"),
                inputType: TextInputType.phone,
              ),
              Widgets.getSizedBox(
                height: 10,
              ),
              editBoxWidget(
                context: context,
                edtController: edtPanNumber,
                validationFunction: GeneralMethods.emptyValidation,
                label: getTranslatedValue(context, "personal_identity_number"),
                inputType: TextInputType.text,
              ),
              Widgets.getSizedBox(
                height: 10,
              ),
              editBoxWidget(
                context: context,
                edtController: edtNationalIdentityCardFilePath,
                validationFunction: GeneralMethods.emptyValidation,
                label:
                    getTranslatedValue(context, "national_identification_card"),
                inputType: TextInputType.none,
                isEditable: true,
                tailIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Single file path
                        GeneralMethods.getFileFromDevice().then(
                          (value) {
                            edtNationalIdentityCardFilePath.text = value;
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsetsDirectional.all(10),
                        child: Widgets.defaultImg(
                          image: "file_icon",
                          iconColor: ColorsRes.appColor,
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Widgets.getSizedBox(
                height: 10,
              ),
              editBoxWidget(
                context: context,
                edtController: edtAddressProofFilePath,
                validationFunction: GeneralMethods.emptyValidation,
                label: getTranslatedValue(context, "address_proof"),
                inputType: TextInputType.none,
                tailIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Single file path
                        GeneralMethods.getFileFromDevice().then((value) {
                          edtAddressProofFilePath.text = value;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsetsDirectional.all(10),
                        child: Widgets.defaultImg(
                          image: "file_icon",
                          iconColor: ColorsRes.appColor,
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
