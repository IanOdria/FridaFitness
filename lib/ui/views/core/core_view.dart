import 'package:flutter/material.dart';
import 'package:fridafit/ui/constants/colors.dart';
import 'package:fridafit/ui/constants/decoration.dart';
import 'package:fridafit/ui/views/core/core_viewmodel.dart';
import 'package:fridafit/ui/views/main/main_view.dart';
import 'package:fridafit/ui/views/program/program_view.dart';

import 'package:stacked/stacked.dart';

class CoreView extends StackedView<CoreViewModel> {
  const CoreView({super.key});

  @override
  Widget builder(BuildContext context, CoreViewModel viewModel, Widget? child) {
    const pages = [
      MainView(),
      ProgramView(),
    ];

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: kPaddingHorizontal,
        child: IndexedStack(index: viewModel.index, children: pages),
      ),
      // Material 3 NavigationBar uses your NavigationBarTheme from app_theme.dart
      bottomNavigationBar: NavigationBar(
        selectedIndex: viewModel.index,
        onDestinationSelected: viewModel.setIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Exercise',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            selectedIcon: Icon(Icons.list_alt_rounded),
            label: 'Program',
          ),
        ],
      ),
    );
  }

  @override
  CoreViewModel viewModelBuilder(BuildContext context) => CoreViewModel();
}
