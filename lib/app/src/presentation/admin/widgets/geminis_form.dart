import 'package:bot_dashboard/app/export_app.dart';

class GeminisForm extends StatefulWidget {
  const GeminisForm({super.key});

  @override
  State<GeminisForm> createState() => _GeminisFormState();
}

class _GeminisFormState extends State<GeminisForm> {
  final _formKey = GlobalKey<FormState>();
  final _apiKeyController = TextEditingController();
  String _selectedModel = availableModels.first;
  bool _isUpdate = false;

  @override
  void initState() {
    super.initState();
    _loadFormData();
  }

  Future<void> _loadFormData() async {
    try {
      final modelConfig = await ModelConfigService().getModelConfig();
      if (modelConfig != null) {
        setState(() {
          _apiKeyController.text = modelConfig.apiKey;
          _selectedModel = modelConfig.model;
          _isUpdate = true;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading model configuration: $e');
      }
    }
  }

  Future<void> _saveFormData(String apiKey, String model) async {
    try {
      await ModelConfigService().createOrUpdateModelConfig(
        apiKey: apiKey,
        model: model,
      );
      if (kDebugMode) {
        print('Model configuration saved successfully: $apiKey, $model');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving model configuration: $e');
      }
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            labelText: 'API Key',
            obscureText: true,
            controller: _apiKeyController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu API Key';
              }
              return null;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () async {
                  const url = 'https://aistudio.google.com/apikey';
                  try {
                    if (!await launchUrl(Uri.parse(url))) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Could not launch API key page'),
                          ),
                        );
                      }
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error launching URL: $e'),
                        ),
                      );
                    }
                  }
                },
                child: TextPadding(
                  text: 'Obtener API Key',
                  color: Colors.blue,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedModel,
            onChanged: (String? newValue) {
              setState(() {
                _selectedModel = newValue!;
              });
            },
            items: availableModels.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Modelo',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // Procesar los datos del formulario
                final geminisModel = GeminisModel(
                  apiKey: _apiKeyController.text,
                  model: _selectedModel,
                );

                // Guardar los datos en Firestore utilizando UserService
                try {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    await _saveFormData(geminisModel.apiKey, geminisModel.model);
                    // Mostrar mensaje de éxito
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('GeminisModel ${_isUpdate ? 'updated' : 'saved'} successfully'),
                        ),
                      );
                    }
                  } else {
                    if (kDebugMode) {
                      print('No user is currently signed in.');
                    }
                  }
                } catch (e) {
                  if (kDebugMode) {
                    print('Error ${_isUpdate ? 'updating' : 'saving'} GeminisModel: $e');
                  }
                }
              }
            },
            child: Text(_isUpdate ? 'Actualizar' : 'Guardar'),
          ),
        ],
      ),
    );
  }
}
