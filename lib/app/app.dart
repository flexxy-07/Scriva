import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scriva/app/router.dart';
import 'package:scriva/features/models/presentation/model_manager_screen.dart';
import 'package:scriva/shared/theme/app_theme.dart';
import 'package:scriva/shared/widgets/loading_indicator.dart';

class ScrivaApp extends ConsumerWidget {
  const ScrivaApp ({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final initialRoute = ref.watch(initialRouteProvider);

    return MaterialApp(
      title: 'Scriva',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: initialRoute.when(data: (route) => switch(route){
        AppRouter.onBoarding => const OnboardingScreen(),
        AppRouter.modelSetup => const ModelManagerScreen(),
        _ => const HomeScreen(),
      }, error: (_, __) => const HomeScreen(), loading: () => const Scaffold(
        body: Center(
          child: LoadingIndicator(),
        ),
      )),
    )

  }
}