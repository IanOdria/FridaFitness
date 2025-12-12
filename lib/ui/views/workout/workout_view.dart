import 'package:flutter/material.dart';
import 'package:fridafit/models/excercise.dart';
import 'package:fridafit/ui/constants/colors.dart';
import 'package:stacked/stacked.dart';
import 'workout_viewmodel.dart';
import 'package:gif/gif.dart';

class WorkoutView extends StatefulWidget {
  final List<Exercise> exercises;
  const WorkoutView({super.key, required this.exercises});

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView>
    with SingleTickerProviderStateMixin {
  late final GifController _gifCtrl;
  String? _lastExerciseId;
  bool _gifReady = false; // ✅ becomes true after fetch completes

  @override
  void initState() {
    super.initState();
    _gifCtrl = GifController(vsync: this);
  }

  @override
  void dispose() {
    _gifCtrl.dispose();
    super.dispose();
  }

  void _syncGifPlayback({required bool paused}) {
    if (!_gifReady) return; // ❗ wait for real bounds
    if (paused) {
      _gifCtrl.stop();
      return;
    }
    final min = _gifCtrl.lowerBound; // set by package after fetch
    final max = _gifCtrl.upperBound; // set by package after fetch
    if (max <= min) return; // extra safety
    _gifCtrl.repeat(
      min: min,
      max: max,
      period: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorkoutViewModel>.reactive(
      viewModelBuilder: () => WorkoutViewModel(plan: widget.exercises),
      onViewModelReady: (vm) => vm.start(),
      builder: (context, vm, _) {
        final theme = Theme.of(context);

        if (vm.phase == WorkoutPhase.done) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Workout', style: TextStyle(color: kTextColor)),
              backgroundColor: kBackgroundColor,
              surfaceTintColor: Colors.transparent,
            ),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.celebration, size: 80),
                  SizedBox(height: 12),
                  Text('All done!',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          );
        }

        final ex = vm.current!;
        final isWork = vm.phase == WorkoutPhase.work;
        final label = isWork ? 'Work' : 'Rest';
        final seconds = vm.remaining;

        // 🔄 If exercise changed, reset readiness & stop controller
        if (_lastExerciseId != ex.id) {
          _lastExerciseId = ex.id;
          _gifReady = false;
          _gifCtrl.stop();
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Workout', style: TextStyle(color: kTextColor)),
            actions: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                child: Text(
                  '${vm.index + 1}/${widget.exercises.length}',
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                // --- GIF AREA ---
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: (ex.gifUrl == null || ex.gifUrl!.isEmpty)
                        ? Container(
                            color: theme.colorScheme.surfaceContainerHighest,
                            child: const Center(child: Text('No GIF')),
                          )
                        : Stack(
                            fit: StackFit.expand,
                            children: [
                              Center(
                                child: Gif(
                                  key: ValueKey(
                                      ex.id), // force reload per exercise
                                  controller: _gifCtrl,
                                  autostart: Autostart.no, // we'll control it
                                  image: NetworkImage(ex.gifUrl!),
                                  placeholder: (context) => const Center(
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  onFetchCompleted: () {
                                    // ✅ Now the controller has real bounds
                                    _gifReady = true;
                                    _syncGifPlayback(paused: vm.paused);
                                  },
                                ),
                              ),
                              // Dim during REST
                              if (!isWork)
                                Container(color: Colors.white.withOpacity(0.6)),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                // --- INFO ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ex.name,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: (isWork ? Colors.green : Colors.orange)
                            .withOpacity(.12),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        label,
                        style: TextStyle(
                          color: isWork ? Colors.green : Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // --- TIMER ---
                SizedBox(
                  height: 180,
                  width: 180,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.scale(
                        scale: 3,
                        child: CircularProgressIndicator(
                          value: vm.progress.clamp(0, 1),
                          strokeWidth: 4,
                          backgroundColor: kGreyLight.withAlpha(40),
                        ),
                      ),
                      Text(
                        _mmss(seconds),
                        style: theme.textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // --- CONTROLS ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        vm.pauseResume();
                        _syncGifPlayback(
                            paused: vm.paused); // will no-op until ready
                      },
                      icon: Icon(vm.paused ? Icons.play_arrow : Icons.pause),
                      label: Text(vm.paused ? 'Resume' : 'Pause'),
                    ),
                    const SizedBox(width: 12),
                    FilledButton.icon(
                      onPressed: () {
                        vm.skip();
                        // Next GIF will trigger onFetchCompleted -> _gifReady=true -> sync playback
                      },
                      icon: const Icon(Icons.skip_next),
                      label: const Text('Skip'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _mmss(int s) {
    final m = s ~/ 60;
    final ss = (s % 60).toString().padLeft(2, '0');
    return '$m:$ss';
  }
}
