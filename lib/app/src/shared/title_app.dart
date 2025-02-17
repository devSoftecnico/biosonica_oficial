import 'package:bot_dashboard/app/export_app.dart';

class TitleApp extends StatelessWidget {
  const TitleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 35.0,
        bottom: MediaQuery.of(context).size.height * 0.2,
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(120.0),
            child: Image.asset(
              AppConfig().logo,
              semanticLabel: AppConfig().logo,
              width: 120.0,
              height: 120.0,
            ),
          ),
          Text(
            AppConfig().titleApp,
            semanticsLabel: AppConfig().titleApp,
            style: const TextStyle(
              color: Colors.limeAccent,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
