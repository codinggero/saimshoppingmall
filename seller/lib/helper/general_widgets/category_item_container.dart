import 'package:flutter/material.dart';
import '../utils/export.dart';

class CategoryItemContainer extends StatelessWidget {
  final CategoryData category;
  final VoidCallback voidCallBack;

  const CategoryItemContainer(
      {Key? key, required this.category, required this.voidCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: voidCallBack,
      child: Container(
        decoration: DesignConfig.boxDecoration(
            Theme.of(context).scaffoldBackgroundColor, 8),
        child: Column(children: [
          Expanded(
            flex: 8,
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.height,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Widgets.setNetworkImg(
                      boxFit: BoxFit.cover,
                      image: category.imageUrl ?? "",
                    ),
                  ),
                ),
                if (context
                    .watch<CategoryListProvider>()
                    .selectedCategories
                    .contains(category.id.toString()))
                  PositionedDirectional(
                    top: 0,
                    start: 0,
                    bottom: 0,
                    end: 0,
                    child: Container(
                        decoration: BoxDecoration(
                            color: ColorsRes.appColorBlack.withOpacity(0.8),
                            borderRadius: Constant.borderRadius5),
                        child: Icon(
                          Icons.check_rounded,
                          color: ColorsRes.appColor,
                          size: 60,
                        )),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                "${category.name}",
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
