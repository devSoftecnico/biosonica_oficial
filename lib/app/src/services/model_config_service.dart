import 'package:bot_dashboard/app/export_app.dart';

class ModelConfigService {
  final CollectionReference _modelsCollection = FirebaseFirestore.instance.collection('biosonica_cloud/account/models');

  Future<void> createOrUpdateModelConfig({
    required String apiKey,
    required String model,
  }) async {
    try {
      final now = DateTime.now();
      final modelConfig = ModelConfig(
        apiKey: apiKey,
        model: model,
        createdAt: now,
        updatedAt: now,
      );
      await _modelsCollection.doc('default').set(modelConfig.toJson());
    } catch (e) {
      if (kDebugMode) {
        print('Error en createOrUpdateModelConfig: $e');
      }
      rethrow;
    }
  }

  Future<ModelConfig?> getModelConfig() async {
    try {
      final modelDoc = await _modelsCollection.doc('default').get();
      if (modelDoc.exists) {
        return ModelConfig.fromJson(modelDoc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error en getModelConfig: $e');
      }
      rethrow;
    }
  }
}
