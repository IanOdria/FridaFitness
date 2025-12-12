import 'package:flutter/material.dart';
import 'package:fridafit/models/excercise.dart';
import 'package:fridafit/ui/constants/colors.dart';
import 'package:fridafit/ui/constants/decoration.dart';
import 'package:stacked/stacked.dart';
import 'exercise_detail_viewmodel.dart';

class ExerciseDetailView extends StatelessWidget {
  final Exercise exercise;
  const ExerciseDetailView({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ViewModelBuilder<ExerciseDetailViewModel>.nonReactive(
      viewModelBuilder: () => ExerciseDetailViewModel(),
      builder: (context, vm, _) {
        final headerUrl = (exercise.thumbUrl?.isNotEmpty ?? false)
            ? exercise.thumbUrl!
            : (exercise.gifUrl ?? '');

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                stretch: true,
                expandedHeight: 280,
                elevation: 0,
                backgroundColor: theme.colorScheme.surface,
                title: Text(
                  exercise.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: kTextColor),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.fadeTitle,
                  ],
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Image header
                      Hero(
                        tag:
                            'exercise-thumb-${exercise.id}', // match ProgramView card if used
                        child: headerUrl.isEmpty
                            ? Container(
                                color:
                                    theme.colorScheme.surfaceContainerHighest,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.image_not_supported_rounded,
                                  size: 32,
                                ),
                              )
                            : Image.network(
                                headerUrl,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.medium,
                                loadingBuilder: (ctx, child, progress) {
                                  if (progress == null) return child;
                                  return Container(
                                    color: theme
                                        .colorScheme.surfaceContainerHighest,
                                  );
                                },
                                errorBuilder: (_, __, ___) => Container(
                                  color:
                                      theme.colorScheme.surfaceContainerHighest,
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.broken_image_rounded,
                                      size: 32),
                                ),
                              ),
                      ),
                      // Gradient overlay for modern look + readability
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.10),
                                Colors.black.withOpacity(0.05),
                                Colors.black.withOpacity(0.30),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Bottom title (big) when expanded
                      Positioned(
                        left: 16,
                        right: 16,
                        bottom: 16,
                        child: Text(
                          exercise.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                            shadows: const [
                              Shadow(blurRadius: 6, color: Colors.black54)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: kPaddingHorizontal
                      .add(const EdgeInsets.only(top: 16, bottom: 24)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Quick chips row (sets / reps / equipment)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _chips(context, exercise),
                      ),
                      const SizedBox(height: 16),

                      // Description card
                      if (exercise.description?.isNotEmpty == true) ...[
                        _SectionCard(
                          icon: Icons.description_outlined,
                          title: 'Description',
                          child: Text(
                            exercise.description!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.35,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],

                      // Details grid card (Sets / Reps / Equipment / Created)
                      _SectionCard(
                        icon: Icons.info_outline_rounded,
                        title: 'Details',
                        child: _DetailsGrid(exercise: exercise),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _chips(BuildContext context, Exercise ex) {
    final theme = Theme.of(context);
    final chips = <Widget>[];

    if (ex.sets != null) chips.add(_chip(theme, 'Sets: ${ex.sets}'));
    if (ex.reps != null) chips.add(_chip(theme, 'Reps: ${ex.reps}'));
    if (ex.equipment?.isNotEmpty == true)
      chips.add(_chip(theme, ex.equipment!));

    // Always show a created-at chip (short)
    final createdShort = '${ex.createdAt.toLocal()}'.split('.').first;
    chips.add(_chip(theme, createdShort));

    return chips;
  }

  Widget _chip(ThemeData theme, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: ShapeDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        shape: StadiumBorder(
          side: BorderSide(color: theme.dividerColor.withOpacity(.35)),
        ),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w700,
          letterSpacing: .2,
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: theme.dividerColor.withOpacity(.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: .2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _DetailsGrid extends StatelessWidget {
  final Exercise exercise;
  const _DetailsGrid({required this.exercise});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget cell(String label, String? value, {IconData? icon}) {
      if (value == null || value.isEmpty) return const SizedBox.shrink();
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.dividerColor.withOpacity(.2)),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        letterSpacing: .3,
                      )),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    final created = '${exercise.createdAt.toLocal()}'.split('.').first;

    return GridView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.3,
      ),
      children: [
        cell('Sets', exercise.sets?.toString(),
            icon: Icons.view_agenda_outlined),
        cell('Reps', exercise.reps?.toString(),
            icon: Icons.countertops_outlined),
        cell('Equipment', exercise.equipment,
            icon: Icons.fitness_center_outlined),
        cell('Created', created, icon: Icons.schedule_outlined),
      ],
    );
  }
}
