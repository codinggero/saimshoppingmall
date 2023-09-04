import 'package:flutter/material.dart';
import '../../../../helper/utils/export.dart';
import '/models/seller_dashboard.dart';

class WeeklySalesBarChart extends StatefulWidget {
  final List<WeeklySales> weeklySales;
  final double maxSaleLimit;

  const WeeklySalesBarChart(
      {Key? key, required this.weeklySales, required this.maxSaleLimit})
      : super(key: key);

  @override
  State<WeeklySalesBarChart> createState() => _WeeklySalesBarChartState();
}

class _WeeklySalesBarChartState extends State<WeeklySalesBarChart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          getTranslatedValue(context, "daily_sales"),
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
          child: BarChart(
            mainBarData(),
          ),
        ),
      ],
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    double width = 22,
    List<int>? showTooltips,
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: ColorsRes.appColor,
          width: MediaQuery.of(context).size.width * 0.1,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() =>
      List.generate(widget.weeklySales.length, (index) {
        return makeGroupData(
          index,
          (double.parse(widget.weeklySales[index].totalSale!)),
        );
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: BarTouchTooltipData(
          tooltipRoundedRadius: 10,
          fitInsideVertically: true,
          fitInsideHorizontally: true,
          tooltipBgColor: Theme.of(context).cardColor,
          tooltipMargin: 10,
          tooltipPadding: EdgeInsets.zero,
          tooltipBorder: BorderSide(color: ColorsRes.appColorBlack, width: 1),
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String selectedDate = widget.weeklySales[group.x].orderDate ?? "";
            return BarTooltipItem(
              "$selectedDate\t${GeneralMethods.getCurrencyFormat(rod.toY - 1)}",
              TextStyle(
                color: ColorsRes.mainTextColor,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
      alignment: BarChartAlignment.spaceAround,
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 40,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
      ),
      barGroups: showingGroups(),
      backgroundColor: Theme.of(context).cardColor,
      gridData: const FlGridData(show: true),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Container(
        decoration: BoxDecoration(
          color: ColorsRes.appColor,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsetsDirectional.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(
            "${widget.weeklySales[value.toInt()].orderDate?.split("-")[2]}-${widget.weeklySales[value.toInt()].orderDate?.split("-")[1]}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: ColorsRes.appColorWhite),
            softWrap: true),
      ),
    );
  }
}
