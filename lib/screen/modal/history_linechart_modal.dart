class HistoryLineChartModal {
  late List<Data> data;
  late int timestamp;

  HistoryLineChartModal({required this.data, required this.timestamp});

  HistoryLineChartModal.fromJson(Map<String, dynamic> json) {
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
  late String priceUsd;
  late int time;

  Data({required this.priceUsd, required this.time});

  Data.fromJson(Map<String, dynamic> json) {
    priceUsd = json['priceUsd'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['priceUsd'] = this.priceUsd;
    data['time'] = this.time;
    return data;
  }
}
