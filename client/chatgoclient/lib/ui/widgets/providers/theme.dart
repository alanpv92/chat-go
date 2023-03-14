import 'dart:developer';

import 'package:chatgoclient/controllers/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeProvider extends ConsumerWidget {
  final Widget child;
  const ThemeProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(themeProvider);
    return child;
  }
}
