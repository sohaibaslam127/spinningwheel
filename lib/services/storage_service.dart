import 'package:get_storage/get_storage.dart';
import 'package:spinningwheel/models/history_model.dart';

class StorageService {
  final GetStorage _storage = GetStorage();
  final String _historyKey = 'history';
  final int _maxHistoryCount = 5;

  init() async {
    await GetStorage.init();
  }

  void saveModel(HistoryModel history) {
    List<HistoryModel> historyList = getModels();
    if (historyList.length >= _maxHistoryCount) {
      historyList.removeAt(0);
    }
    historyList.add(history);
    _storage.write(
      _historyKey,
      historyList.map((model) => model.toMap()).toList(),
    );
  }

  List<HistoryModel> getModels() {
    final List<dynamic> storedData =
        _storage.read<List<dynamic>>(_historyKey) ?? [];
    return storedData
        .map((item) => HistoryModel.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> clearHistory() async {
    await _storage.remove(_historyKey);
  }
}
