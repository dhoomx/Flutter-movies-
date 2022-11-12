import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnvironmentConfig {
  final movieApiKey = const String.fromEnvironment("moviApiKey");
}

final environmentConfigProvider = Provider<EnvironmentConfig>((ref) {
  return EnvironmentConfig();
});
