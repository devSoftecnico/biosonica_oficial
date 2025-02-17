import 'package:bot_dashboard/app/export_app.dart';

class TextPadding extends StatelessWidget {
  final double? top;
  final double? bottom;
  final String text;
  final String? semanticsLabel;
  final Color? color;
  final double? fontSize;

  const TextPadding({
    super.key,
    this.top = 0.0,
    this.bottom = 0.0,
    required this.text,
    this.semanticsLabel,
    this.color = Colors.blueGrey,
    this.fontSize = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: top!,
        bottom: bottom!,
      ),
      child: Text(
        text,
        semanticsLabel: semanticsLabel,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
        ),
      ),
    );
  }
}
