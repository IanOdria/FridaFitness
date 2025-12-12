import 'package:stacked/stacked.dart';

class CoreViewModel extends ReactiveViewModel {
  int _index = 0;
  int get index => _index;

  void setIndex(int i) {
    if (i == _index) return;
    _index = i;
    notifyListeners();
  }
}
