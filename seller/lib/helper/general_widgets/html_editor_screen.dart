import 'package:flutter/material.dart';
import '../utils/export.dart';
import 'package:flutter/foundation.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class HtmlEditorScreen extends StatefulWidget {
  final String? htmlContent;

  const HtmlEditorScreen({Key? key, this.htmlContent}) : super(key: key);

  @override
  HtmlEditorScreenState createState() => HtmlEditorScreenState();
}

class HtmlEditorScreenState extends State<HtmlEditorScreen> {
  String result = '';
  final HtmlEditorController controller = HtmlEditorController();

  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 400),
      () {
        controller.setFullScreen();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          controller.clearFocus();
        }
      },
      child: Scaffold(
        appBar: getAppBar(
          title: Text(
            "Html Editor",
            style: TextStyle(color: ColorsRes.mainTextColor),
          ),
          actions: [
            IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  if (kIsWeb) {
                    controller.reloadWeb();
                  } else {
                    controller.editorController!.reload();
                  }
                })
          ],
          context: context,
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.all(7),
                child: HtmlEditor(
                  controller: controller,
                  htmlEditorOptions: HtmlEditorOptions(
                    shouldEnsureVisible: true,
                    darkMode: Constant.session
                        .getBoolData(SessionManager.isDarkTheme),
                    initialText: widget.htmlContent,
                    adjustHeightForKeyboard: true,
                    mobileLongPressDuration: const Duration(microseconds: 500),
                    spellCheck: true,
                    autoAdjustHeight: true,
                  ),
                  htmlToolbarOptions: HtmlToolbarOptions(
                    toolbarPosition: ToolbarPosition.belowEditor,
                    renderSeparatorWidget: true,
                    renderBorder: true,
                    toolbarType: ToolbarType.nativeScrollable,
                    buttonFocusColor: ColorsRes.appColor,
                    onButtonPressed: (ButtonType type, bool? status,
                        Function? updateStatus) {
                      return true;
                    },
                    initiallyExpanded: true,
                    onDropdownChanged: (DropdownType type, dynamic changed,
                        Function(dynamic)? updateSelectedItem) {
                      return true;
                    },
                    mediaLinkInsertInterceptor:
                        (String url, InsertFileType type) {
                      return true;
                    },
                    mediaUploadInterceptor:
                        (PlatformFile file, InsertFileType type) async {
                      return true;
                    },
                    customToolbarInsertionIndices: [2, 5],
                    buttonBorderWidth: 0,
                    buttonSelectedColor: ColorsRes.appColor,
                    buttonColor: ColorsRes.mainTextColor,
                    buttonFillColor: ColorsRes.appColorLightHalfTransparent,
                    buttonBorderColor: ColorsRes.appColor,
                    defaultToolbarButtons: [
                      const OtherButtons(),
                      const FontSettingButtons(),
                      const FontButtons(),
                      const ColorButtons(),
                      const InsertButtons(),
                      const ListButtons(),
                      const ParagraphButtons(),
                      const StyleButtons()
                    ],
                  ),
                  otherOptions: OtherOptions(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).cardColor)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 7, end: 7, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Widgets.gradientBtnWidget(
                      context,
                      10,
                      title: "Done",
                      isSetShadow: false,
                      callback: () {
                        Navigator.pop(context, controller.getText());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
