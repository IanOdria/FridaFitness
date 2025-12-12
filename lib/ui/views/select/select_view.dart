import 'package:flutter/material.dart';
import 'package:fridafit/app/app.locator.dart';
import 'package:fridafit/ui/constants/colors.dart';
import 'package:fridafit/ui/constants/decoration.dart';
import 'package:fridafit/ui/views/workout/workout_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'select_viewmodel.dart';

class SelectView extends StatelessWidget {
  const SelectView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectViewModel>.reactive(
      viewModelBuilder: () => SelectViewModel(),
      builder: (context, vm, _) {
        final items = vm.data ?? [];
        final canStart = vm.selected.isNotEmpty;

        return Scaffold(
          appBar: AppBar(
              title: const Text(
            'Select Exercises',
            style: TextStyle(color: kTextColor),
          )),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: FilledButton(
                onPressed: canStart
                    ? () => locator<NavigationService>().navigateToView(
                          WorkoutView(exercises: vm.selectedList),
                        )
                    : null,
                child: Text(
                  canStart
                      ? 'Start (${vm.selected.length})'
                      : 'Select to start',
                ),
              ),
            ),
          ),
          body: vm.isBusy && items.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : items.isEmpty
                  ? const Center(child: Text('No exercises yet'))
                  : ListView.separated(
                      padding: kPaddingHorizontal,
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(height: 0),
                      itemBuilder: (_, i) {
                        final ex = items[i];
                        final checked = vm.selected.containsKey(ex.id);

                        return CheckboxListTile(
                          value: checked,
                          onChanged: (v) => vm.toggle(ex, v ?? false),

                          // Animated GIF preview at the start of the tile
                          secondary: SizedBox(
                            height: 56,
                            width: 56,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: ex.gifUrl == null || ex.gifUrl!.isEmpty
                                  ? Container(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceContainerHighest,
                                      child: const Icon(
                                        Icons.image_not_supported_rounded,
                                        size: 20,
                                      ),
                                    )
                                  : Image.network(
                                      ex.gifUrl!,
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.medium,
                                    ),
                            ),
                          ),

                          title: Text(
                            ex.name,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(_subtitle(ex)),
                          controlAffinity: ListTileControlAffinity.trailing,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                        );
                      },
                    ),
        );
      },
    );
  }

  String _subtitle(dynamic ex) {
    final parts = <String>[];
    if (ex.sets != null) parts.add('Sets: ${ex.sets}');
    if (ex.reps != null) parts.add('Reps: ${ex.reps}');
    if (ex.equipment?.isNotEmpty == true) parts.add(ex.equipment!);
    return parts.isEmpty ? (ex.description ?? '') : parts.join(' • ');
  }
}
