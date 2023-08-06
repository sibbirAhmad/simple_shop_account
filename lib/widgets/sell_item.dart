import 'package:flutter/material.dart';
import 'package:simple_account/models/api_models.dart';

class SellItem extends StatelessWidget {

  ProductDataModel productDataModel;
  SellItem({
   required this.productDataModel
});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          // print("${item.name} pressed");
          print("pressed");
        },
        leading: Image.asset("images/food.png"),
        title: Text(productDataModel.productName),
        subtitle: Text(productDataModel.sellTime),
        trailing: Text(
          "${productDataModel.sellPrice-productDataModel.buyPrice}TK",
          textScaleFactor: 1.5,
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
