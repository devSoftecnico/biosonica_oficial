import 'package:bot_dashboard/app/export_app.dart';

class AppConfigForm extends StatefulWidget {
  const AppConfigForm({super.key});

  @override
  State<AppConfigForm> createState() => _AppConfigFormState();
}

class _AppConfigFormState extends State<AppConfigForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleAppController = TextEditingController();
  final _infoController = TextEditingController();
  final _logoAppController = TextEditingController();
  final _logoGoogleController = TextEditingController();
  final _googleSessionController = TextEditingController();
  final _appBarColorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            labelText: 'Title App',
            controller: _titleAppController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Title App';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            labelText: 'Info',
            controller: _infoController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Info';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            labelText: 'Logo App',
            controller: _logoAppController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Logo App';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            labelText: 'Logo Google',
            controller: _logoGoogleController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Logo Google';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            labelText: 'Google Session',
            controller: _googleSessionController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Google Session';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            labelText: 'App Bar Color',
            controller: _appBarColorController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the App Bar Color';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Procesar los datos del formulario
                final appConfigModel = AppConfigModel(
                  titleApp: _titleAppController.text,
                  info: _infoController.text,
                  logoApp: _logoAppController.text,
                  logoGoogle: _logoGoogleController.text,
                  googleSession: _googleSessionController.text.toLowerCase() == 'true',
                  appBarColor: Color(int.parse(_appBarColorController.text)),
                );
                // Aquí puedes guardar o usar el modelo según tus necesidades
                if (kDebugMode) {
                  print('AppConfigModel: $appConfigModel');
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
