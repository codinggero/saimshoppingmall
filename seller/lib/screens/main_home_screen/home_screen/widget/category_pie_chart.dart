import 'package:flutter/material.dart';
import '../../../../helper/utils/export.dart';
import '/models/seller_dashboard.dart';

class CategoryPieChart extends StatefulWidget {
  final List<CategoryProductCount> categoryProductCounts;

  const CategoryPieChart({Key? key, required this.categoryProductCounts})
      : super(key: key);

  @override
  State<CategoryPieChart> createState() => _CategoryPieChartState();
}

class _CategoryPieChartState extends State<CategoryPieChart> {
  int touchedIndex = -1;

  List<Color> colors = [];

  @override
  void initState() {
    Future.delayed(
        Duration.zero,
        () => colors = List.generate(
              widget.categoryProductCounts.length,
              (index) => Color.fromRGBO(
                Random().nextInt(255),
                Random().nextInt(255),
                Random().nextInt(255),
                1,
              ),
            )).then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (colors.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslatedValue(context, "title_product_wise_category_count"),
            style: TextStyle(
              color: ColorsRes.appColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      startDegreeOffset: 180,
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: List.generate(
                          widget.categoryProductCounts.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Indicator(
                            color: colors[index],
                            text:
                                widget.categoryProductCounts[index].name ?? "",
                            count: widget.categoryProductCounts[index]
                                    .productCount ??
                                "0",
                            textColor: touchedIndex == index
                                ? ColorsRes.mainTextColor
                                : ColorsRes.grey,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.categoryProductCounts.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;

      return PieChartSectionData(
        color: colors[i],
        value:
            double.parse(widget.categoryProductCounts[i].productCount ?? "0"),
        title: "",
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: isTouched ? ColorsRes.mainTextColor : ColorsRes.grey,
        ),
      );
    });
  }
}
