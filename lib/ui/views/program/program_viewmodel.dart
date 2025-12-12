import 'package:fridafit/app/app.locator.dart';
import 'package:fridafit/models/excercise.dart';
import 'package:fridafit/services/excercise_service.dart';
import 'package:stacked/stacked.dart';

class ProgramViewModel extends StreamViewModel<List<Exercise>> {
  final _svc = locator<ExerciseService>();

  @override
  Stream<List<Exercise>> get stream => _svc.watchAll();
}
