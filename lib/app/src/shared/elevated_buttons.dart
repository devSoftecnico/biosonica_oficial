import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final String? imagePath;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final bool isDarkMode;
  final String? semanticsLabel;
  final String? semanticLabelImage;

  const CustomElevatedButton({
    super.key,
    this.text,
    this.icon,
    this.imagePath,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.height,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.isDarkMode = true,
    this.semanticsLabel,
    this.semanticLabelImage,
  }) : assert(
          text != null || icon != null || imagePath != null,
          'At least one of text, icon, or imagePath must be provided',
        );

  @override
  Widget build(BuildContext context) {
    final defaultBackgroundColor = isDarkMode ? const Color(0xFF1F2C34) : Colors.teal[400];
    final defaultForegroundColor = isDarkMode ? Colors.white : Colors.white;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? defaultBackgroundColor,
          foregroundColor: foregroundColor ?? defaultForegroundColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 2,
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    final List<Widget> content = [];

    if (icon != null) {
      content.add(Icon(icon));
      if (text != null) content.add(const SizedBox(width: 8));
    }

    if (imagePath != null) {
      content.add(
        Image.asset(
          imagePath!,
          height: 24,
          width: 24,
          semanticLabel: semanticLabelImage,
          color: foregroundColor,
          fit: BoxFit.contain,
        ),
      );
      if (text != null) content.add(const SizedBox(width: 8));
    }

    if (text != null) {
      content.add(
        Text(
          text!,
          semanticsLabel: semanticsLabel,
          style: const TextStyle(fontSize: 16),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: content,
    );
  }
}
