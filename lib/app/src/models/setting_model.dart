import 'dart:ui';

class SettingModel {
  final String apiKey;
  final String model;
  final String titleApp;
  final String info;
  final String logoApp;
  final String logoGoogle;
  final bool googleSession;
  final Color appBarColor;

  SettingModel({
    required this.apiKey,
    required this.model,
    required this.titleApp,
    required this.info,
    required this.logoApp,
    required this.logoGoogle,
    required this.googleSession,
    required this.appBarColor,
  });
}
