part of '../model_manager_screen.dart';
import '../../home/presentation/home_screen.dart';
class _ContinueButtonView extends StatelessWidget {
  const _ContinueButtonView();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AppButton(
        label: 'Continue to Scriva',
        icon: Icons.arrow_forward_rounded,
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        ),
      ),
    );
  }
}
