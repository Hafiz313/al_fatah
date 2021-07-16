// To parse this JSON data, do
//
//     final inventoryResultModel = inventoryResultModelFromJson(jsonString);

import 'dart:convert';

List<InventoryResultModel> inventoryResultModelFromJson(List<dynamic> str) => List<InventoryResultModel>.from((str).map((x) => InventoryResultModel.fromJson(x)));

String inventoryResultModelToJson(List<InventoryResultModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InventoryResultModel {
  InventoryResultModel({
    this.code,
    this.name,
    this.type,
    this.style,
    this.salesRate,
    this.mUnit,
    this.color,
    this.sSize,
    this.oldCode,
    this.purchaseRate,
    this.discountType,
    this.discountVal,
    this.disCont,
    this.gstTax,
    this.brandCode,
    this.brandName,
    this.typeName,
    this.styleName,
    this.smRate,
    this.wholeSale,
    this.groupFix,
    this.companyFix,
    this.lockRate,
    this.commission,
    this.stock,
  });

  String code;
  String name;
  String type;
  String style;
  double salesRate;
  String mUnit;
  String color;
  String sSize;
  String oldCode;
  double purchaseRate;
  String discountType;
  double discountVal;
  bool disCont;
  double gstTax;
  String brandCode;
  String brandName;
  String typeName;
  String styleName;
  double smRate;
  double wholeSale;
  double groupFix;
  double companyFix;
  double lockRate;
  double commission;
  List<Stock> stock;

  factory InventoryResultModel.fromJson(Map<String, dynamic> json) => InventoryResultModel(
    code: json["Code"],
    name: json["name"],
    type: json["type"],
    style: json["style"],
    salesRate: json["sales_rate"],
    mUnit: json["m_unit"],
    color: json["color"],
    sSize: json["s_size"],
    oldCode: json["old_code"],
    purchaseRate: json["purchase_rate"],
    discountType: json["discount_type"],
    discountVal: json["discount_val"],
    disCont: json["dis_cont"],
    gstTax: json["GST_Tax"],
    brandCode: json["BrandCode"],
    brandName: json["BrandName"],
    typeName: json["TypeName"],
    styleName: json["StyleName"],
    smRate: json["SMRate"],
    wholeSale: json["WholeSale"],
    groupFix: json["GroupFix"],
    companyFix: json["CompanyFix"],
    lockRate: json["LockRate"],
    commission: json["Commission"],
    stock: List<Stock>.from(json["Stock"].map((x) => Stock.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "name": name,
    "type": type,
    "style": style,
    "sales_rate": salesRate,
    "m_unit": mUnit,
    "color": color,
    "s_size": sSize,
    "old_code": oldCode,
    "purchase_rate": purchaseRate,
    "discount_type": discountType,
    "discount_val": discountVal,
    "dis_cont": disCont,
    "GST_Tax": gstTax,
    "BrandCode": brandCode,
    "BrandName": brandName,
    "TypeName": typeName,
    "StyleName": styleName,
    "SMRate": smRate,
    "WholeSale": wholeSale,
    "GroupFix": groupFix,
    "CompanyFix": companyFix,
    "LockRate": lockRate,
    "Commission": commission,
    "Stock": List<dynamic>.from(stock.map((x) => x.toJson())),
  };
}

class Stock {
  Stock({
    this.location,
    this.locationName,
    this.itemCode,
    this.stock,
    this.fyear,
  });

  String location;
  String locationName;
  String itemCode;
  double stock;
  String fyear;

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
    location: json["Location"],
    locationName: json["LocationName"],
    itemCode: json["ItemCode"],
    stock: json["Stock"],
    fyear: json["Fyear"],
  );

  Map<String, dynamic> toJson() => {
    "Location": location,
    "LocationName": locationName,
    "ItemCode": itemCode,
    "Stock": stock,
    "Fyear": fyear,
  };
}
