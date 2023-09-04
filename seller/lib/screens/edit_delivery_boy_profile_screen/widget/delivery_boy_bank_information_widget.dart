import 'package:flutter/material.dart';
import '../../../helper/utils/export.dart';

class DeliveryBoyBankInformationWidget extends StatefulWidget {
  final Map<String, String> personalData;

  const DeliveryBoyBankInformationWidget({Key? key, required this.personalData})
      : super(key: key);

  @override
  State<DeliveryBoyBankInformationWidget> createState() =>
      DeliveryBoyBankInformationWidgetState();
}

class DeliveryBoyBankInformationWidgetState
    extends State<DeliveryBoyBankInformationWidget> {
  late TextEditingController edtBankName,
      edtAccountNumber,
      edtIFSCCode,
      edtAccountName;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    edtBankName = TextEditingController(
      text: widget.personalData[ApiAndParams.bank_name] ??
          Constant.session.getData(SessionManager.bank_name),
    );
    edtAccountNumber = TextEditingController(
      text: widget.personalData[ApiAndParams.bank_account_number] ??
          Constant.session.getData(SessionManager.bank_account_number),
    );
    edtIFSCCode = TextEditingController(
      text: widget.personalData[ApiAndParams.ifsc_code] ??
          Constant.session.getData(SessionManager.ifsc_code),
    );
    edtAccountName = TextEditingController(
      text: widget.personalData[ApiAndParams.account_name] ??
          Constant.session.getData(SessionManager.account_name),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: DesignConfig.setRoundedBorder(7),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Constant.paddingOrMargin10,
          vertical: Constant.paddingOrMargin10,
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslatedValue(context, "bank_information"),
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
                edtController: edtBankName,
                validationFunction: GeneralMethods.emptyValidation,
                label: getTranslatedValue(context, "bank_name"),
                inputType: TextInputType.text,
              ),
              Widgets.getSizedBox(
                height: 10,
              ),
              editBoxWidget(
                context: context,
                edtController: edtAccountNumber,
                validationFunction: GeneralMethods.emptyValidation,
                label: getTranslatedValue(context, "account_number"),
                inputType: const TextInputType.numberWithOptions(
                    signed: false, decimal: true),
              ),
              Widgets.getSizedBox(
                height: 10,
              ),
              editBoxWidget(
                context: context,
                edtController: edtIFSCCode,
                validationFunction: GeneralMethods.emptyValidation,
                label: getTranslatedValue(context, "ifsc_code"),
                inputType: TextInputType.text,
              ),
              Widgets.getSizedBox(
                height: 10,
              ),
              editBoxWidget(
                context: context,
                edtController: edtAccountName,
                validationFunction: GeneralMethods.emptyValidation,
                label: getTranslatedValue(context, "account_name"),
                inputType: TextInputType.text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
