class GeminisModel {
  final String apiKey;
  final String model;

  GeminisModel({
    required this.apiKey,
    required this.model,
  });
}

final List<String> availableModels = [
  'gemini-2.0-flash',
  'gemini-2.0-flash-lite-preview-02-05',
  'gemini-1.5-flash',
  'gemini-1.5-flash-8b',
  'gemini-1.5-pro',
  'text-embedding-004',
  'gemini-pro',
  'gemini-pro-vision',
];
