part of '../model_manager_screen.dart';

class _ContinueButtonView extends StatelessWidget {
  const _ContinueButtonView();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AppButton(
        label: 'INITIALIZE SYSTEM',
        icon: Icons.power_settings_new,
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        ),
      ),
    );
  }
}
