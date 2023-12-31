import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/controllers/grocery_controller.dart';
import 'package:quickgrocer_application/src/features/core/models/grocery_model.dart';
import 'package:quickgrocer_application/src/features/core/models/stock_report_model.dart';
import 'package:quickgrocer_application/src/features/core/screens/report/pdf_api.dart';
import 'package:quickgrocer_application/src/features/core/screens/report/pdf_stockreport_api.dart';
import 'package:quickgrocer_application/src/features/core/screens/report/sales_report_choose_date.dart';

class ViewReportScreen extends StatefulWidget {
  const ViewReportScreen({super.key});

  @override
  State<ViewReportScreen> createState() => _ViewReportScreenState();
}

class _ViewReportScreenState extends State<ViewReportScreen> {
  String? selectedValue;
  List<String> reportList = <String>['Sales Report', 'Stocks Report'];

  @override
  Widget build(BuildContext context) {
    var iconColorWithoutBackground =
        Get.isDarkMode ? Colors.white : Colors.black;
    final grocController = Get.put(GroceryController());

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(LineAwesomeIcons.angle_left,
                  color: iconColorWithoutBackground)),
          title: Text(
            report,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: Center(
        child: Container(
            padding: EdgeInsets.all(32),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.picture_as_pdf_rounded,
                size: 50,
              ),
              SizedBox(
                height: 10,
              ),
              Text('Generate Report',
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: formHeight),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        Get.to(() => SalesReportChooseDateScreen()),
                    child: Text(reportList[0]),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      List<GroceryModel> grocery =
                          await grocController.getAllGroceriesReport();
                      StockReportModel stockReport =
                          StockReportModel(grocery: grocery);
                      final pdfFile =
                          await PdfStockReportApi.generate(stockReport);

                      PdfApi.openFile(pdfFile);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                    ),
                    child: Text(reportList[1]),
                  )),
            ])),
      ),
    );
  }
}
