import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingIndicator extends StatelessWidget {
  final String? message;
  const LoadingIndicator({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 200,
          height: 2,
          child: LinearProgressIndicator(
            backgroundColor: AppColors.surface2,
            color: AppColors.primary,
          ),
        ),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(
            message!.toUpperCase(),
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textSecondary,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
        ]
      ],
    );
  }
}