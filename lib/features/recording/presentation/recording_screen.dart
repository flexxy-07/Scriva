import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/features/models/presentation/recording_controller.dart';
import 'dart:math' as math;
import '../domain/recording_state.dart';
import '../../../shared/theme/app_theme.dart';
import '../../transcription/presentation/transcription_screen.dart';

class RecordingScreen extends ConsumerWidget {
  const RecordingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recordingControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scriva'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded,
                color: AppColors.textSecondary),
            onPressed: () {
              // History screen — coming in Step 5
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),
              _buildVisualizer(state),
              const SizedBox(height: 32),
              _buildTimer(state),
              const SizedBox(height: 12),
              _buildStatusText(state),
              const Spacer(flex: 3),
              _buildControls(context, ref, state),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVisualizer(RecordingState state) {
    return SizedBox(
      height: 120,
      child: state.isRecording
          ? const _PulsingWaveform()
          : _IdleCircle(isPaused: state.isPaused),
    );
  }

  Widget _buildTimer(RecordingState state) {
    final d = state.duration;
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');

    final timeString =
        hours > 0 ? '$hours:$minutes:$seconds' : '$minutes:$seconds';

    return Text(
      timeString,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 52,
        fontWeight: FontWeight.w200,
        letterSpacing: -1,
        fontFeatures: [FontFeature.tabularFigures()],
      ),
    );
  }

  Widget _buildStatusText(RecordingState state) {
    final (text, color) = switch (state.status) {
      RecordingStatus.idle => ('Tap to record', AppColors.textSecondary),
      RecordingStatus.recording => ('Recording...', AppColors.primary),
      RecordingStatus.paused => ('Paused', AppColors.textSecondary),
      RecordingStatus.stopped => ('Processing...', AppColors.success),
    };

    if (state.errorMessage != null) {
      return Text(state.errorMessage!,
          style: const TextStyle(color: AppColors.error, fontSize: 14));
    }

    return Text(text,
        style: TextStyle(color: color, fontSize: 15));
  }

  Widget _buildControls(
      BuildContext context, WidgetRef ref, RecordingState state) {
    final controller = ref.read(recordingControllerProvider.notifier);

    if (state.isIdle) {
      return _RecordButton(
        onTap: () => controller.startRecording(),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Cancel
        _CircleButton(
          icon: Icons.close_rounded,
          color: AppColors.surface2,
          size: 56,
          onTap: () => controller.cancelRecording(),
        ),
        const SizedBox(width: 24),

        // Pause / Resume
        _CircleButton(
          icon: state.isRecording
              ? Icons.pause_rounded
              : Icons.mic_rounded,
          color: AppColors.primary.withOpacity(0.15),
          iconColor: AppColors.primary,
          size: 72,
          onTap: () => state.isRecording
              ? controller.pauseRecording()
              : controller.resumeRecording(),
        ),
        const SizedBox(width: 24),

        // Stop → transcribe
        _CircleButton(
          icon: Icons.stop_rounded,
          color: AppColors.success.withOpacity(0.15),
          iconColor: AppColors.success,
          size: 56,
          onTap: () async {
            final path = await controller.stopRecording();
            if (path != null && context.mounted) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TranscriptionScreen(audioPath: path),
                ),
              );
            }
            controller.reset();
          },
        ),
      ],
    );
  }
}

// Pulsing waveform animation while recording
class _PulsingWaveform extends StatefulWidget {
  const _PulsingWaveform();

  @override
  State<_PulsingWaveform> createState() => _PulsingWaveformState();
}

class _PulsingWaveformState extends State<_PulsingWaveform>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final _random = math.Random();
  List<double> _heights = [];

  @override
  void initState() {
    super.initState();
    _heights = List.generate(32, (_) => 0.3 + _random.nextDouble() * 0.7);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _heights =
                List.generate(32, (_) => 0.2 + _random.nextDouble() * 0.8);
          });
          _controller.forward(from: 0);
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(_heights.length, (i) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 4,
              height: 20 + (_heights[i] * 80),
              decoration: BoxDecoration(
                color: AppColors.primary
                    .withOpacity(0.4 + _heights[i] * 0.6),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        );
      },
    );
  }
}

// Idle / paused circle
class _IdleCircle extends StatefulWidget {
  final bool isPaused;
  const _IdleCircle({required this.isPaused});

  @override
  State<_IdleCircle> createState() => _IdleCircleState();
}

class _IdleCircleState extends State<_IdleCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _scale = Tween(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.isPaused
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.surface,
          border: Border.all(
            color: widget.isPaused
                ? AppColors.primary.withOpacity(0.4)
                : AppColors.surface2,
            width: 1.5,
          ),
        ),
        child: Icon(
          widget.isPaused ? Icons.pause_rounded : Icons.mic_none_rounded,
          color: widget.isPaused
              ? AppColors.primary
              : AppColors.textSecondary,
          size: 40,
        ),
      ),
    );
  }
}

// Big record button for idle state
class _RecordButton extends StatelessWidget {
  final VoidCallback onTap;
  const _RecordButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 88,
        height: 88,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.35),
              blurRadius: 24,
              spreadRadius: 4,
            ),
          ],
        ),
        child: const Icon(Icons.mic_rounded, color: Colors.white, size: 38),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color? iconColor;
  final double size;
  final VoidCallback onTap;

  const _CircleButton({
    required this.icon,
    required this.color,
    required this.onTap,
    required this.size,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: Icon(icon,
            color: iconColor ?? AppColors.textSecondary,
            size: size * 0.42),
      ),
    );
  }
}