import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/features/models/presentation/recording_controller.dart';
import 'dart:math' as math;
import '../domain/recording_state.dart';
import '../../../shared/theme/app_theme.dart';
import '../../transcription/presentation/transcription_screen.dart';
import 'package:google_fonts/google_fonts.dart';

part 'views/recording_visualizer_view.dart';
part 'views/recording_timer_view.dart';
part 'views/recording_status_text_view.dart';
part 'views/recording_controls_view.dart';

class RecordingScreen extends ConsumerWidget {
  const RecordingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recordingControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SCRIVA',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              _VisualizerView(state: state),
              const SizedBox(height: 48),
              _TimerView(state: state),
              const SizedBox(height: 16),
              _StatusTextView(state: state),
              const Spacer(flex: 3),
              _ControlsView(state: state),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }
}

// Technical Waveform Visualizer
class _TechnicalWaveform extends StatefulWidget {
  const _TechnicalWaveform();

  @override
  State<_TechnicalWaveform> createState() => _TechnicalWaveformState();
}

class _TechnicalWaveformState extends State<_TechnicalWaveform>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final _random = math.Random();
  List<double> _heights = [];

  @override
  void initState() {
    super.initState();
    _heights = List.generate(24, (_) => 0.1 + _random.nextDouble() * 0.9);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _heights =
                List.generate(24, (_) => 0.1 + _random.nextDouble() * 0.9);
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
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(_heights.length, (i) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 6,
              height: 10 + (_heights[i] * 100),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.zero, // Sharp corners
              ),
            );
          }),
        );
      },
    );
  }
}

// Technical Mic Indicator (Square)
class _TechnicalMicIndicator extends StatelessWidget {
  final bool isPaused;
  const _TechnicalMicIndicator({required this.isPaused});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(
          color: isPaused ? AppColors.primary : AppColors.surface2,
          width: 2,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            isPaused ? Icons.pause_outlined : Icons.mic_none_outlined,
            color: isPaused ? AppColors.primary : AppColors.textSecondary,
            size: 48,
          ),
          if (!isPaused)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 8,
                height: 8,
                color: AppColors.textSecondary.withValues(alpha: 0.3),
              ),
            ),
        ],
      ),
    );
  }
}

// Square Action Button
class _SquareActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final String? label;

  const _SquareActionButton({
    required this.onTap,
    required this.icon,
    this.backgroundColor = AppColors.surface,
    this.iconColor = AppColors.textPrimary,
    this.size = 64,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                color: AppColors.surface2,
                width: 1,
              ),
            ),
            child: Icon(icon, color: iconColor, size: size * 0.4),
          ),
          if (label != null) ...[
            const SizedBox(height: 8),
            Text(
              label!.toUpperCase(),
              style: GoogleFonts.spaceGrotesk(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Technical Record Button
class _TechnicalRecordButton extends StatelessWidget {
  final VoidCallback onTap;
  const _TechnicalRecordButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
          color: AppColors.primary,
        ),
        child: const Center(
          child: Icon(
            Icons.mic_none_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }
}