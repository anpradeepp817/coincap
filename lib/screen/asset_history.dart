import 'package:coincap/bloc/asset_bloc.dart';
import 'package:coincap/networking/Response.dart';
import 'package:coincap/screen/asset_details.dart';
import 'package:coincap/screen/error/internet_connectiondialog.dart';
import 'package:coincap/screen/modal/assets_modal.dart';
import 'package:coincap/screen/modal/history_linechart_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'utils/utils.dart';

class AssetHistory extends StatefulWidget {
  var id;
  AssetHistory({@required this.id});

  @override
  _AssetHistoryState createState() => _AssetHistoryState();
}

class _AssetHistoryState extends State<AssetHistory> {
  late AssetBloc _assetBloc;

  @override
  void initState() {
    _assetBloc = AssetBloc();
    _assetBloc.getAssetHistory(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("History"),
        ),
        body: FutureBuilder(
          future: Utils.check(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return StreamBuilder<Response<HistoryLineChartModal>>(
                  stream: _assetBloc.getAssetHistoryStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data!.status) {
                        case Status.LOADING:
                          break;
                        case Status.COMPLETED:
                          return ListView.builder(
                              itemCount: snapshot.data!.data.data.length,
                              itemBuilder: (context, i) {
                                var data = snapshot.data!.data.data[i];
                               var dt= DateTime.fromMillisecondsSinceEpoch(data.time);
                                var date = DateFormat('MM/dd/yyyy, hh:mm a').format(dt); // 12/31/2000, 10:00 PM

                                return InkWell(
                                  child: Stack(
                                    children: [
                                      Card(
                                        margin:
                                            EdgeInsets.all(5).copyWith(top: 10),
                                        elevation: 10,
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                             
                                           
                                           
                                          
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Price(USD)",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                    double.parse(data.priceUsd).toStringAsFixed(2),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Date",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                    date,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 40,
                                        height: 20,
                                        padding:
                                            EdgeInsets.only(left: 2, right: 2),
                                        margin: EdgeInsets.only(left: 5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            color: Colors.blue),
                                        child: Text(
                                          "SN. ${(i + 1)}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                  onTap: () {

                                  },
                                );
                              });
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
