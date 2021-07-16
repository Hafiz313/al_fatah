import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_app/core/datamodels/InventoryResultModel.dart';
import 'package:inventory_app/utils/app_color.dart';
import 'package:inventory_app/utils/app_sizes.dart';
import 'package:inventory_app/views/widgets/app_text_styles.dart';

import '../base_view.dart';


class ItemResultScreen extends StatefulWidget {

  final InventoryResultModel inventoryResultModel;

  const ItemResultScreen({Key key, this.inventoryResultModel}) : super(key: key);
  @override
  _ItemResultScreenState createState() => _ItemResultScreenState();
}

class _ItemResultScreenState extends State<ItemResultScreen> {

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return BaseScaffold(
      body:SingleChildScrollView(
        child: Column(

          children: [

            Container(
              height: AppSizes.appVerticalLg * 2,
              width: AppSizes.appHorizontalLg * 3,
              child: Image(
                image: AssetImage("images/logo.png"),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 10,right: 10,bottom: 20),
                alignment: Alignment.centerLeft,
                child: Center(child: Text("${widget.inventoryResultModel.name}",style: simpleText(fontSize: 20,color: kAppPrimaryColor),textAlign: TextAlign.center,))),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),

              child: Table(
                border: TableBorder.all(
                    color: kAppPrimaryColor,
                    style: BorderStyle.solid,
                    width: 2),
                children: [
                  TableRow(
                      children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Text('SM Rate', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('${widget.inventoryResultModel.smRate}', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),

                  ]),
                  TableRow(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('Wholesale', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('${widget.inventoryResultModel.wholeSale}', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),

                      ]),
                  TableRow(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('Group Fix', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('${widget.inventoryResultModel.groupFix}', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),

                      ]),
                  TableRow(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('Company Fix', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('${widget.inventoryResultModel.companyFix}', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),

                      ]),
                  TableRow(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('Lock Rate', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('${widget.inventoryResultModel.lockRate}', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),

                      ]),
                  TableRow(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('Commission', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('${widget.inventoryResultModel.commission}', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),

                      ]),




              ],),

            ),
            SizedBox(height: 30,),
            widget.inventoryResultModel.stock.length >0?  Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),

              child:Table(

                border: TableBorder.all(
                    color: kAppPrimaryColor,
                    style: BorderStyle.solid,
                    width: 2),
                children:
                List.generate(widget.inventoryResultModel.stock.length,(index){
    return TableRow(children: [
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('${widget.inventoryResultModel.stock[index].locationName}', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text('${widget.inventoryResultModel.stock[index].stock}', style: TextStyle(fontSize: 20.0),overflow: TextOverflow.ellipsis,)),
                      ]);}
                ,),
            )
            ):Container()],
        ),
      ))

    ;}

}


