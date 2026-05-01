import 'package:flutter/material.dart';
import 'package:scriva/features/models/presentation/model_manager_screen.dart';
import 'package:scriva/shared/theme/app_theme.dart';

class ScrivaApp extends StatelessWidget {
  const ScrivaApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Scriva',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const ModelManagerScreen(),
    );
  }
}