import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_provider.g.dart';

// Initialized in main() and overridden in runApp()
@riverpod
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError();
}
