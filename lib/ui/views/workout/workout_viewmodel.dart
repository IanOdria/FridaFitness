import 'dart:async';
import 'package:fridafit/models/excercise.dart';
import 'package:stacked/stacked.dart';

enum WorkoutPhase { work, rest, done }

class WorkoutViewModel extends BaseViewModel {
  final List<Exercise> plan;
  final int workSeconds;
  final int restSeconds;

  WorkoutViewModel({
    required this.plan,
    this.workSeconds = 60,
    this.restSeconds = 10,
  });

  int _index = 0;
  int _remaining = 0;
  WorkoutPhase _phase = WorkoutPhase.work;
  Timer? _timer;
  bool _paused = false;

  int get index => _index;
  int get remaining => _remaining;
  WorkoutPhase get phase => _phase;
  bool get paused => _paused;

  Exercise? get current => _index < plan.length ? plan[_index] : null;
  double get progress {
    final total = _phase == WorkoutPhase.work ? workSeconds : restSeconds;
    if (total == 0) return 1;
    return 1 - (_remaining / total);
  }

  void start() {
    if (plan.isEmpty) {
      _phase = WorkoutPhase.done;
      notifyListeners();
      return;
    }
    _phase = WorkoutPhase.work;
    _remaining = workSeconds;
    _tick();
  }

  void _tick() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_paused) return;
      if (_remaining > 0) {
        _remaining--;
        notifyListeners();
      } else {
        _advance();
      }
    });
  }

  void _advance() {
    if (_phase == WorkoutPhase.work) {
      _phase = WorkoutPhase.rest;
      _remaining = restSeconds;
      notifyListeners();
    } else {
      // finished rest, move to next exercise
      _index++;
      if (_index >= plan.length) {
        _phase = WorkoutPhase.done;
        _timer?.cancel();
      } else {
        _phase = WorkoutPhase.work;
        _remaining = workSeconds;
      }
      notifyListeners();
    }
  }

  void pauseResume() {
    _paused = !_paused;
    notifyListeners();
  }

  void skip() {
    if (_phase == WorkoutPhase.work) {
      // skip to rest immediately
      _phase = WorkoutPhase.rest;
      _remaining = restSeconds;
    } else {
      // skip rest → next exercise (or done)
      _index++;
      if (_index >= plan.length) {
        _phase = WorkoutPhase.done;
        _timer?.cancel();
      } else {
        _phase = WorkoutPhase.work;
        _remaining = workSeconds;
      }
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
