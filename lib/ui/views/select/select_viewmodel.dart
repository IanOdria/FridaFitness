import 'package:fridafit/app/app.locator.dart';
import 'package:fridafit/models/excercise.dart';
import 'package:fridafit/services/excercise_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SelectViewModel extends StreamViewModel<List<Exercise>> {
  final _svc = locator<ExerciseService>();
  final _navigationService = locator<NavigationService>();

  final _selected = <String, Exercise>{};

  @override
  Stream<List<Exercise>> get stream => _svc.watchAll();

  Map<String, Exercise> get selected => _selected;

  @override
  void onData(List<Exercise>? data) {
    super.onData(data);
    if (data != null && data.isNotEmpty && _selected.isEmpty) {
      // ✅ Preselect everything when data loads
      for (final e in data) {
        _selected[e.id] = e;
      }
      notifyListeners();
    }
  }

  void navigateTo(String route) {
    _navigationService.navigateTo(route);
  }

  void toggle(Exercise e, bool value) {
    if (value) {
      _selected[e.id] = e;
    } else {
      _selected.remove(e.id);
    }
    notifyListeners();
  }

  List<Exercise> get selectedList => _selected.values.toList(growable: false);
}
