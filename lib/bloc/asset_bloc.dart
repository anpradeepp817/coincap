import 'dart:async';

import 'package:coincap/networking/Response.dart';
import 'package:coincap/repo/asset_respository.dart';
import 'package:coincap/screen/modal/assets_detailsmodal.dart';
import 'package:coincap/screen/modal/assets_modal.dart';
import 'package:coincap/screen/modal/history_linechart_modal.dart';

class AssetBloc {
  late AssetRepository _assetRepository;
  late StreamController _streamController ,_assetDetailsController,_historyDetailsController;

  Stream<Response<AssetsModal>>? get getAssetStream =>
      _streamController.stream as Stream<Response<AssetsModal>>;

  StreamSink<Response<AssetsModal>> get _getAssetSink =>
      _streamController.sink as StreamSink<Response<AssetsModal>>;

  Stream<Response<AssetsDetailsModal>>? get getAssetDetailsStream =>
      _assetDetailsController.stream as Stream<Response<AssetsDetailsModal>>;

  StreamSink<Response<AssetsDetailsModal>> get _getAssetDetailsSink =>
      _assetDetailsController.sink as StreamSink<Response<AssetsDetailsModal>>;


  Stream<Response<HistoryLineChartModal>>? get getAssetHistoryStream =>
      _historyDetailsController.stream as Stream<Response<HistoryLineChartModal>>;

  StreamSink<Response<HistoryLineChartModal>> get _getAssetHistorySink =>
      _historyDetailsController.sink as StreamSink<Response<HistoryLineChartModal>>;

  AssetBloc() {
    _assetRepository = AssetRepository();
    _streamController = StreamController<Response<AssetsModal>>.broadcast();
    _assetDetailsController = StreamController<Response<AssetsDetailsModal>>.broadcast();
    _historyDetailsController = StreamController<Response<HistoryLineChartModal>>.broadcast();
  }

  getAssetData() async {
    _getAssetSink.add(Response.loading("loading data"));

    try {
      AssetsModal assetsModal = await _assetRepository.getAsset();

      print("modal ${assetsModal.data}");
      if (assetsModal.data.isEmpty) {
        _getAssetSink.add(Response.error("Data not found"));
      } else {
        _getAssetSink.add(Response.completed(assetsModal));
      }
    } catch (e) {
      print("error ${e.toString()}");
      _getAssetSink.add(Response.error(e.toString()));
    }
  }
  getAssetDataByID({required String id}) async {
    _getAssetDetailsSink.add(Response.loading("loading data"));

    try {
      AssetsDetailsModal assetsModal = await _assetRepository.getAssetDataById(id: id);

      print("modal ${assetsModal.data}");
      if (assetsModal == null) {
        _getAssetDetailsSink.add(Response.error("Data not found"));
      } else {
        _getAssetDetailsSink.add(Response.completed(assetsModal));
      }
    } catch (e) {
      print("error ${e.toString()}");
      _getAssetDetailsSink.add(Response.error(e.toString()));
    }
  }

  getAssetHistory({required String id}) async {
    _getAssetHistorySink.add(Response.loading("loading data"));

    try {
      HistoryLineChartModal assetsModal = await _assetRepository.getAssetDataHistory(id: id);

      print("modal ${assetsModal.data}");
      if (assetsModal == null) {
        _getAssetHistorySink.add(Response.error("Data not found"));
      } else {
        _getAssetHistorySink.add(Response.completed(assetsModal));
      }
    } catch (e) {
      print("error ${e.toString()}");
      _getAssetHistorySink.add(Response.error(e.toString()));
    }
  }
}
