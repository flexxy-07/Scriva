import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool isLoading;
  final Color? color;

  const AppButton({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    this.isLoading = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Absolute sharp corners
          ),
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    const SizedBox(width: 12),
                  ],
                  Text(
                    label.toUpperCase(),
                    style: GoogleFonts.spaceGrotesk(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}