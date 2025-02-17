import 'dart:ui';

class AppConfigModel {
  final String titleApp;
  final String info;
  final String logoApp;
  final String logoGoogle;
  final bool googleSession;
  final Color appBarColor;

  AppConfigModel({
    required this.titleApp,
    required this.info,
    required this.logoApp,
    required this.logoGoogle,
    required this.googleSession,
    required this.appBarColor,
  });
}
