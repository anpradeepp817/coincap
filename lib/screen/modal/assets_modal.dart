class AssetsModal {
  late List<Data> data;
  late int timestamp;

  AssetsModal({required this.data, required this.timestamp});

  AssetsModal.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Data {
  late String id;
  late String rank;
  late String symbol;
  late String name;
  late String supply;
  late String maxSupply;
  late String marketCapUsd;
  late String volumeUsd24Hr;
  late String priceUsd;
  late String changePercent24Hr;
  late String vwap24Hr;
  late String explorer;
  late String vwap2assets4Hr;

  Data(
      {required this.id,
      required this.rank,
      required this.symbol,
      required this.name,
      required this.supply,
      required this.maxSupply,
      required this.marketCapUsd,
      required this.volumeUsd24Hr,
      required this.priceUsd,
      required this.changePercent24Hr,
      required this.vwap24Hr,
      required this.explorer,
      required this.vwap2assets4Hr});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rank = json['rank'];
    symbol = json['symbol'];
    name = json['name'];
    supply = json['supply'];
    maxSupply = json['maxSupply'] ?? "";
    marketCapUsd = json['marketCapUsd'] ?? "";
    volumeUsd24Hr = json['volumeUsd24Hr']??"";
    priceUsd = json['priceUsd']??'';
    changePercent24Hr = json['changePercent24Hr'] ??"";
    vwap24Hr = json['vwap24Hr']??"";
    explorer = json['explorer']??"";
    vwap2assets4Hr = json['vwap2assets4Hr']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rank'] = this.rank;
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    data['supply'] = this.supply;
    data['maxSupply'] = this.maxSupply;
    data['marketCapUsd'] = this.marketCapUsd;
    data['volumeUsd24Hr'] = this.volumeUsd24Hr;
    data['priceUsd'] = this.priceUsd;
    data['changePercent24Hr'] = this.changePercent24Hr;
    data['vwap24Hr'] = this.vwap24Hr;
    data['explorer'] = this.explorer;
    data['vwap2assets4Hr'] = this.vwap2assets4Hr;
    return data;
  }
}
