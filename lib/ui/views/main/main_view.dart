import 'package:flutter/material.dart';
import 'package:fridafit/app/app.router.dart';
import 'package:fridafit/ui/theme/app_theme.dart';
import 'package:fridafit/ui/views/main/main_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brand = theme.extension<TechBrand>()!;
    final cs = theme.colorScheme;

    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: cs.surface,
          body: SafeArea(
            child: Stack(
              children: [
                // Header near top – does NOT affect button centering
                Positioned(
                  top: 30,
                  left: 24,
                  right: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        'Welcome Back',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: .8,
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Ready for your next session?',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                // START button – always perfectly centered
                Align(
                  alignment: Alignment.center,
                  child: _NeonStartButton(
                    onTap: () => vm.navigateTo(Routes.selectView),
                    gradient: brand.heroGradient,
                    glowShadow: brand.glowShadow,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NeonStartButton extends StatefulWidget {
  final VoidCallback onTap;
  final Gradient gradient;
  final List<BoxShadow> glowShadow;

  const _NeonStartButton({
    required this.onTap,
    required this.gradient,
    required this.glowShadow,
  });

  @override
  State<_NeonStartButton> createState() => _NeonStartButtonState();
}

class _NeonStartButtonState extends State<_NeonStartButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulse = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return RepaintBoundary(
      child: GestureDetector(
        onTap: widget.onTap,
        child: SizedBox(
          width: 220,
          height: 220,
          child: AnimatedBuilder(
            animation: _pulse,
            builder: (_, __) {
              final ringScale1 = 1.2 + (_pulse.value * 0.35);
              final ringScale2 = 1.2 + (((_pulse.value + .5) % 1.0) * 0.35);
              final ringOpacity1 = (1 - _pulse.value) * 0.45;
              final ringOpacity2 = (1 - ((_pulse.value + .5) % 1.0)) * 0.35;

              return Stack(alignment: Alignment.center, children: [
                Transform.scale(
                  scale: ringScale1,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primary.withOpacity(ringOpacity1),
                      boxShadow: [
                        BoxShadow(
                          color: primary.withOpacity(ringOpacity1),
                          blurRadius: 60,
                          spreadRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                Transform.scale(
                  scale: ringScale2,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primary.withOpacity(ringOpacity2),
                      boxShadow: [
                        BoxShadow(
                          color: primary.withOpacity(ringOpacity2),
                          blurRadius: 60,
                          spreadRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: widget.gradient,
                    boxShadow: widget.glowShadow,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'START',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                  ),
                ),
              ]);
            },
          ),
        ),
      ),
    );
  }
}
