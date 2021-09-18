import 'package:coincap/networking/APIProvider.dart';
import 'package:coincap/networking/APIs.dart';
import 'package:coincap/screen/modal/assets_detailsmodal.dart';
import 'package:coincap/screen/modal/assets_modal.dart';
import 'package:coincap/screen/modal/history_linechart_modal.dart';

class AssetRepository {
  APIProvider _apiProvider = APIProvider();

  Future<AssetsModal> getAsset() async {
    var response = await _apiProvider.get(getAssetApi);
    return AssetsModal.fromJson(response);
  }
  Future<AssetsDetailsModal> getAssetDataById({required String id}) async {
    var response = await _apiProvider.get(getAssetApi + "/$id");
    return AssetsDetailsModal.fromJson(response);
  }

  Future<HistoryLineChartModal> getAssetDataHistory({required String id}) async {
    var response = await _apiProvider.get(getAssetApi + "/$id"+"/history?interval=d1");
    return HistoryLineChartModal.fromJson(response);
  }
}
