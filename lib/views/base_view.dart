import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inventory_app/utils/app_sizes.dart';
import 'package:progress_dialog/progress_dialog.dart';

// ignore: must_be_immutable
class BaseScaffold extends StatefulWidget {
  final Widget body;
  final Color backgroudColor;
  final bool backgroundImage;
  final bool internetFunction;

  const BaseScaffold(
      {@required this.body,
        this.backgroudColor, this.backgroundImage=true, this.internetFunction = true,
      });

  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  bool _isNetworkConnected = true;
  // Connectivity _connectivity;
  StreamSubscription _subscription;
  // @override
  // void initState() {
  //   _connectivity = Connectivity();
  //   _subscription = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
  //     if (result == ConnectivityResult.wifi ||
  //         result == ConnectivityResult.mobile) {
  //       setState(() {
  //         //Conncted to mobile or wifi
  //         print("----------------------Internet Connected-----------------");
  //         _isNetworkConnected = true;
  //       });
  //     } else {
  //       setState(() {
  //         print(
  //             "----------------------Internet Not Connected-----------------");
  //         _isNetworkConnected = false;
  //       });
  //     }
  //   });
  //
  //   super.initState();
  // }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    AppSizes().init(context);
    return SafeArea(

      child: Container(
        child: Scaffold(
            body: ( _isNetworkConnected || !widget.internetFunction) ?
            Container(
              width: double.infinity,
              decoration:BoxDecoration(
                  color: widget.backgroudColor ?? Colors.white,
                  // image: widget.backgroundImage ?
                  // DecorationImage(
                  //     fit:BoxFit.fill,
                  //     image: AssetImage("images/bg.png")
                  // ): null
              ),
              child: widget.body,
            ) :  Container(
              height: AppSizes.screenHeight -
                  AppSizes.blockSizeVertical * 5.0,
              child: Center(
                child:
                Image.asset("images/no_internet.png"),
              ),
            )),
      ),
    );
  }
}