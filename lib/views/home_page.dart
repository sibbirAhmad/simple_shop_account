import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simple_account/models/api_models.dart';
import 'package:simple_account/utils/constants.dart';
import 'package:simple_account/utils/sp.dart';
import 'package:simple_account/widgets/sell_item.dart';
import 'package:http/http.dart' as http;
import 'package:gson/gson.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
   Home({super.key});


  Widget build(BuildContext context) {
    return DashboardSF();
  }

}
class DashboardSF extends StatefulWidget {
  const DashboardSF({super.key});

  @override
  State<DashboardSF> createState() => _DashboardSFState();
}

class _DashboardSFState extends State<DashboardSF> {
  // List<SellItem> items = [
  //   SellItem(title: "Banan", sellTime: "sellTime", profit: 123),
  //   SellItem(title: "Banan 2", sellTime: "sellTime", profit: 23),
  //   SellItem(title: "Banan 3", sellTime: "sellTime", profit: 90),
  // ];
  final buyingPriceController = TextEditingController();
  final sellingPriceController = TextEditingController();
  final productNameController = TextEditingController();
  double profit = 0;
  double buyingPrice = 0;
  double sellingPrice = 0;
  @override
  void initState() {
    // TODO: implement initState
    sellingPriceController.addListener(() {
      _updateProfit();
    });
    buyingPriceController.addListener(() {_updateProfit();});
    super.initState();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    buyingPriceController.dispose();
    sellingPriceController.dispose();
    productNameController.dispose();
    super.dispose();
  }
  void _updateProfit(){
    setState(() {
      buyingPrice =  double.parse(buyingPriceController.text);
       sellingPrice = double.parse(sellingPriceController.text);
      profit = sellingPrice - buyingPrice;
    });
  }
  List<ProductDataModel> list = [];
  getSells() async{
    var url = Uri.parse(ApiConstants.baseUrl);
    http.Response response = await http.get(url);
    var body = json.decode(response.body);
    //list = toSellModel(body);

    setState(() {
      list = toSellModel(body);
    });
  }
  void sendToServer()async{
    var url = Uri.parse(ApiConstants.baseUrl);
    http.Response response = await http.post(url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode(<String, String>{
        'request': "ADD_SELL",
        'productName': productNameController.text,
        'sellPrice': sellingPriceController.text,
        'buyPrice': buyingPriceController.text,
        'sellTime': dateToStr,
      }),
    );
    print("Response -- > "+response.body);
    var data = json.decode(response.body);
    print("Response ---> "+data['responseData']);
  }

  DateTime selected = DateTime.now();
  DateTime initial = DateTime(2000);
  DateTime last = DateTime(2025);
  String dateToStr = DateTime.now().toLocal().toString();
  int selectedTimeStamp = 0;
  Future displayDatePicker(BuildContext context) async {
    var date = await showDatePicker(
      context: context,
      initialDate: selected,
      firstDate: initial,
      lastDate: last,
    );

    if (date != null) {
      setState(() {
        dateToStr = date.toLocal().toString().split(" ")[0];
        selectedTimeStamp = date.microsecondsSinceEpoch;
        print("Updating : "+dateToStr);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height:double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 20.0,bottom: 10.0),
                  // height: double.infinity,

                  child: Center(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Add New Sell',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.0,),
                        TextFormField(
                          // onChanged: (val){ //Todo : Not prefffered
                          //   _updateText(val);
                          // },
                           controller: productNameController,
                          decoration: const InputDecoration(
                            labelText: "Enter product name",
                            prefixIcon: Icon(Icons.production_quantity_limits),
                            // suffixIcon: Icon(Icons.clear),
                            border: OutlineInputBorder(),


                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Row(
                          children: [
                            Expanded(
                              child:  TextFormField(
                                // onChanged: (val){ //Todo : Not prefffered
                                //   buyingPrice = val as double;
                                // },
                                keyboardType: const TextInputType.numberWithOptions(
                                  decimal: true,
                                  signed: false,
                                ),
                                controller: buyingPriceController,
                                decoration: const InputDecoration(
                                  labelText: "Buying price",
                                  prefixIcon: Icon(Icons.attach_money),
                                  // suffixIcon: Icon(Icons.clear),
                                  border: OutlineInputBorder(),


                                ),
                              ),
                            ),
                            SizedBox(width: 5.0,),
                            Expanded(
                              child:  TextFormField(
                                // onChanged: (val){ //Todo : Not prefffered
                                //   sellingPrice =  int.parse(_heightCon.text);;
                                //   _updateProfit();
                                // },
                                controller: sellingPriceController,
                                keyboardType: const TextInputType.numberWithOptions(
                                  decimal: true,
                                  signed: false,
                                ),
                                decoration: const InputDecoration(
                                  labelText: "Selling price",
                                  prefixIcon: Icon(Icons.money_off),

                                  // suffixIcon: Icon(Icons.clear),
                                  border: OutlineInputBorder(),


                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10.0,),
                        ElevatedButton.icon(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            textStyle: TextStyle(color: Colors.black),
                            minimumSize: const Size.fromHeight(50), // NEW
                          ),
                          label:  Text("Date : ${dateToStr}",
                            style: TextStyle(fontSize: 18,color: Colors.black),
                          ),
                          onPressed: () async {
                            var date = await showDatePicker(
                            context: context,
                            initialDate: selected,
                            firstDate: initial,
                            lastDate: last,
                            );

                            if (date != null) {
                              setState(() {
                                dateToStr = date.toLocal().toString().split(" ")[0];
                                selectedTimeStamp = date.microsecondsSinceEpoch;
                                print("Updating : "+dateToStr);
                              });
                            }
                          },
                           icon: const Icon(Icons.calendar_month_outlined,color: Colors.black),
                        ),

                        const SizedBox(height: 10.0,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            minimumSize: const Size.fromHeight(50), // NEW
                          ),
                          onPressed: () {
                            sendToServer();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text("Updating...Please waite")));

                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        const SizedBox(height: 10.0,),
                        Text("Profit : $profit",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.green),)
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){
          // Navigator.pop(context);
        }, icon: const Icon(Icons.menu)),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return SellItem(productDataModel: list[index]) ;
          },
        ),
      ),
    );
  }
}

