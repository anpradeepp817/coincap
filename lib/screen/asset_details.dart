import 'package:coincap/bloc/asset_bloc.dart';
import 'package:coincap/networking/Response.dart';
import 'package:coincap/screen/asset_history.dart';
import 'package:coincap/screen/error/internet_connectiondialog.dart';
import 'package:coincap/screen/modal/assets_detailsmodal.dart';
import 'package:coincap/screen/modal/assets_modal.dart';
import 'package:flutter/material.dart';

import 'utils/utils.dart';

class AssetDetails extends StatefulWidget {
  String id;

  AssetDetails({required this.id});

  @override
  _AssetDetailsState createState() => _AssetDetailsState();
}

class _AssetDetailsState extends State<AssetDetails> {
  late AssetBloc _assetBloc;

  @override
  void initState() {
    _assetBloc = AssetBloc();
    _assetBloc.getAssetDataByID(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Asset Detail"),
        ),
        body: FutureBuilder(
          future: Utils.check(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return StreamBuilder<Response<AssetsDetailsModal>>(
                  stream: _assetBloc.getAssetDetailsStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data!.status) {
                        case Status.LOADING:
                          break;
                        case Status.COMPLETED:
                          var data = snapshot.data!.data.data;
                          return Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Rank",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      data.rank,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Symbol",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      data.symbol,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Name",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      data.name,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Price(USD)",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      double.parse(data.priceUsd)
                                          .toStringAsFixed(2),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Change Percent 24Hr",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      double.parse(data.changePercent24Hr)
                                          .toStringAsFixed(2),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Symbol",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      data.symbol,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "History Line Chart",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AssetHistory(id: data.id)));
                                        },
                                        child: Text(
                                          "View",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontSize: 15,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blue),
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          );
                          break;
                        case Status.ERROR:
                          return Container(
                            child: Text(snapshot.data!.message),
                          );
                          break;
                      }
                    }
                    return Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: LinearProgressIndicator(),
                          ),
                          Text("Loading Data")
                        ],
                      ),
                    );
                  },
                );
              } else {
                return InternetConnectionDialog(
                    errorMessage: "No Internet Connection");
              }
            }
            return Container(
              child: Text("checking"),
            );
          },
        ));
  }
}
