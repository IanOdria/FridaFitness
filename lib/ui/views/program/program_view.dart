import 'package:flutter/material.dart';
import 'package:fridafit/app/app.locator.dart';
import 'package:fridafit/models/excercise.dart';
import 'package:fridafit/ui/constants/colors.dart';
import 'package:fridafit/ui/constants/decoration.dart';
import 'package:fridafit/ui/views/exercise_detail/exercise_detail_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'program_viewmodel.dart';

class ProgramView extends StatelessWidget {
  const ProgramView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ViewModelBuilder<ProgramViewModel>.reactive(
      viewModelBuilder: () => ProgramViewModel(),
      builder: (context, vm, _) {
        final items = vm.data ?? [];
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              'Program',
              style: TextStyle(color: kTextColor),
            ),
            backgroundColor: kBackgroundColor,
            surfaceTintColor: Colors.transparent,
          ),
          body: vm.isBusy && items.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : items.isEmpty
                  ? const Center(
                      child: Text('There are no exercises in your program yet'))
                  : GridView.builder(
                      padding: kPaddingHorizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // ⬅️ two-column grid
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 0.8, // nice tall modern cards
                      ),
                      itemCount: items.length,
                      itemBuilder: (_, i) =>
                          _ProgramCard(ex: items[i], theme: theme),
                    ),
        );
      },
    );
  }
}

class _ProgramCard extends StatelessWidget {
  final Exercise ex;
  final ThemeData theme;
  const _ProgramCard({required this.ex, required this.theme});

  @override
  Widget build(BuildContext context) {
    final thumb = ex.thumbUrl ?? '';
    final surfaceHi = theme.colorScheme.surfaceContainerHighest;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => locator<NavigationService>()
          .navigateToView(ExerciseDetailView(exercise: ex)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // Soft modern shadow
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
          color: theme.colorScheme.surface, // fallback color
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image header with gradient overlay (modern look)
            AspectRatio(
              aspectRatio: 16 / 11,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Thumb image or placeholder
                  if (thumb.isEmpty)
                    Container(
                      color: surfaceHi,
                      child: const Icon(Icons.image_not_supported_rounded,
                          size: 28),
                    )
                  else
                    Image.network(
                      thumb,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.medium,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.broken_image_rounded, size: 28),
                    ),

                  // Subtle gradient for title readability
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.0),
                            Colors.black.withOpacity(0.10),
                            Colors.black.withOpacity(0.40),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Title on image (modern, bold)
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 10,
                    child: Text(
                      ex.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.1,
                        shadows: [
                          const Shadow(blurRadius: 4, color: Colors.black54),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Body
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Details line
                    Text(
                      _subtitle(ex),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.25,
                      ),
                    ),
                    const Spacer(),
                    // Subtle CTA row
                    Row(
                      children: [
                        const SizedBox(width: 6),
                        Text(
                          'See more',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w700,
                            letterSpacing: .3,
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.chevron_right_rounded,
                            color: theme.colorScheme.onSurfaceVariant),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _subtitle(Exercise ex) {
    final parts = <String>[];
    if (ex.sets != null) parts.add('Sets: ${ex.sets}');
    if (ex.reps != null) parts.add('Reps: ${ex.reps}');
    if (ex.equipment?.isNotEmpty == true) parts.add(ex.equipment!);
    return parts.isEmpty ? (ex.description ?? '') : parts.join(' • ');
  }
}
