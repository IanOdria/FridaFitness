// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i9;
import 'package:flutter/material.dart';
import 'package:fridafit/models/excercise.dart' as _i10;
import 'package:fridafit/ui/views/core/core_view.dart' as _i2;
import 'package:fridafit/ui/views/exercise_detail/exercise_detail_view.dart'
    as _i8;
import 'package:fridafit/ui/views/main/main_view.dart' as _i3;
import 'package:fridafit/ui/views/program/program_view.dart' as _i7;
import 'package:fridafit/ui/views/select/select_view.dart' as _i5;
import 'package:fridafit/ui/views/startup/startup_view.dart' as _i4;
import 'package:fridafit/ui/views/workout/workout_view.dart' as _i6;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i11;

class Routes {
  static const coreView = '/core-view';

  static const mainView = '/main-view';

  static const startupView = '/startup-view';

  static const selectView = '/select-view';

  static const workoutView = '/workout-view';

  static const programView = '/program-view';

  static const exerciseDetailView = '/exercise-detail-view';

  static const all = <String>{
    coreView,
    mainView,
    startupView,
    selectView,
    workoutView,
    programView,
    exerciseDetailView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.coreView,
      page: _i2.CoreView,
    ),
    _i1.RouteDef(
      Routes.mainView,
      page: _i3.MainView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i4.StartupView,
    ),
    _i1.RouteDef(
      Routes.selectView,
      page: _i5.SelectView,
    ),
    _i1.RouteDef(
      Routes.workoutView,
      page: _i6.WorkoutView,
    ),
    _i1.RouteDef(
      Routes.programView,
      page: _i7.ProgramView,
    ),
    _i1.RouteDef(
      Routes.exerciseDetailView,
      page: _i8.ExerciseDetailView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.CoreView: (data) {
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.CoreView(),
        settings: data,
      );
    },
    _i3.MainView: (data) {
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.MainView(),
        settings: data,
      );
    },
    _i4.StartupView: (data) {
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.StartupView(),
        settings: data,
      );
    },
    _i5.SelectView: (data) {
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.SelectView(),
        settings: data,
      );
    },
    _i6.WorkoutView: (data) {
      final args = data.getArgs<WorkoutViewArguments>(nullOk: false);
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i6.WorkoutView(key: args.key, exercises: args.exercises),
        settings: data,
      );
    },
    _i7.ProgramView: (data) {
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.ProgramView(),
        settings: data,
      );
    },
    _i8.ExerciseDetailView: (data) {
      final args = data.getArgs<ExerciseDetailViewArguments>(nullOk: false);
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i8.ExerciseDetailView(key: args.key, exercise: args.exercise),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class WorkoutViewArguments {
  const WorkoutViewArguments({
    this.key,
    required this.exercises,
  });

  final _i9.Key? key;

  final List<_i10.Exercise> exercises;

  @override
  String toString() {
    return '{"key": "$key", "exercises": "$exercises"}';
  }

  @override
  bool operator ==(covariant WorkoutViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.exercises == exercises;
  }

  @override
  int get hashCode {
    return key.hashCode ^ exercises.hashCode;
  }
}

class ExerciseDetailViewArguments {
  const ExerciseDetailViewArguments({
    this.key,
    required this.exercise,
  });

  final _i9.Key? key;

  final _i10.Exercise exercise;

  @override
  String toString() {
    return '{"key": "$key", "exercise": "$exercise"}';
  }

  @override
  bool operator ==(covariant ExerciseDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.exercise == exercise;
  }

  @override
  int get hashCode {
    return key.hashCode ^ exercise.hashCode;
  }
}

extension NavigatorStateExtension on _i11.NavigationService {
  Future<dynamic> navigateToCoreView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.coreView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMainView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.mainView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSelectView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.selectView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToWorkoutView({
    _i9.Key? key,
    required List<_i10.Exercise> exercises,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.workoutView,
        arguments: WorkoutViewArguments(key: key, exercises: exercises),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProgramView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.programView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToExerciseDetailView({
    _i9.Key? key,
    required _i10.Exercise exercise,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.exerciseDetailView,
        arguments: ExerciseDetailViewArguments(key: key, exercise: exercise),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCoreView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.coreView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMainView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.mainView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSelectView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.selectView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithWorkoutView({
    _i9.Key? key,
    required List<_i10.Exercise> exercises,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.workoutView,
        arguments: WorkoutViewArguments(key: key, exercises: exercises),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProgramView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.programView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithExerciseDetailView({
    _i9.Key? key,
    required _i10.Exercise exercise,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.exerciseDetailView,
        arguments: ExerciseDetailViewArguments(key: key, exercise: exercise),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
