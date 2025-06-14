class HistoryModel {
  final String id;
  final int number;

  HistoryModel({required this.id, required this.number});

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(id: map['id'] as String, number: map['number'] as int);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'number': number};
  }
}
