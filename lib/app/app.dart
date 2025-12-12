import 'package:fridafit/services/excercise_service.dart';
import 'package:fridafit/ui/views/core/core_view.dart';
import 'package:fridafit/ui/views/exercise_detail/exercise_detail_view.dart';
import 'package:fridafit/ui/views/main/main_view.dart';
import 'package:fridafit/ui/views/program/program_view.dart';
import 'package:fridafit/ui/views/select/select_view.dart';

import 'package:fridafit/ui/views/startup/startup_view.dart';
import 'package:fridafit/ui/views/workout/workout_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: CoreView),
    MaterialRoute(page: MainView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: SelectView),
    MaterialRoute(page: WorkoutView),
    MaterialRoute(page: ProgramView),
    MaterialRoute(page: ExerciseDetailView),

    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: ExerciseService),

    // @stacked-service
  ],
)
class App {}
