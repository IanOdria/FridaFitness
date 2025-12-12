import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fridafit/ui/constants/colors.dart';
import 'package:fridafit/ui/constants/text.dart';
import 'package:stacked/stacked.dart';
import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 229, 96, 55),
              Color.fromARGB(255, 232, 139, 114),
            ],
          ),
        ),
        child: Center(
            child: KText.headingThree(
          'fridafit',
          textColor: Colors.white,
        )),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
