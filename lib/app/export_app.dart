export 'package:flutter/foundation.dart' hide kIsWasm;
export 'package:googleapis_auth/googleapis_auth.dart';
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'dart:convert';
export 'dart:async';
export 'dart:math';
export 'dart:io';

// Packages
export 'package:marquee/marquee.dart';
export 'package:provider/provider.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Packages Firebase
export 'package:lottie/lottie.dart';
export 'package:just_audio/just_audio.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:google_sign_in/google_sign_in.dart';
export 'package:cloud_firestore/cloud_firestore.dart';

// Options
export 'package:bot_dashboard/firebase_options.dart';

// Models
export 'package:bot_dashboard/app/src/models/user_model.dart';
export 'package:bot_dashboard/app/src/models/audio_model.dart';
export 'package:bot_dashboard/app/src/models/model_config.dart';
export 'package:bot_dashboard/app/src/models/chat_message.dart';
export 'package:bot_dashboard/app/src/models/geminis_model.dart';
export 'package:bot_dashboard/app/src/models/app_config_model.dart';

// Services
export 'package:bot_dashboard/app/src/services/user_service.dart';
export 'package:bot_dashboard/app/src/services/login_service.dart';
export 'package:bot_dashboard/app/src/services/google_service.dart';
export 'package:bot_dashboard/app/src/services/gemini_service.dart';
export 'package:bot_dashboard/app/src/services/firebase_service.dart';
export 'package:bot_dashboard/app/src/services/model_config_service.dart';
export 'package:bot_dashboard/app/src/services/google_drive_service.dart';

// Providers

export 'package:bot_dashboard/app/src/providers/auth_notifier.dart';
export 'package:bot_dashboard/app/src/providers/audio_provider.dart';
export 'package:bot_dashboard/app/src/presentation/admin/view_models/chat_view_model.dart';

// Form Data

// Presentation
export 'package:bot_dashboard/app/src/presentation/auth/login.dart';
export 'package:bot_dashboard/app/src/presentation/admin/admin.dart';
export 'package:bot_dashboard/app/src/presentation/public/views/terminos_uso_view.dart';
export 'package:bot_dashboard/app/src/presentation/admin/widgets/message_bubble.dart';

// Views
export 'package:bot_dashboard/app/src/presentation/auth/views/login_view.dart';
export 'package:bot_dashboard/app/src/presentation/admin/views/admin_view.dart';
export 'package:bot_dashboard/app/src/presentation/public/views/helper_view.dart';
export 'package:bot_dashboard/app/src/presentation/admin/views/store_view.dart';
export 'package:bot_dashboard/app/src/presentation/public/views/politica_devolucion_view.dart';
export 'package:bot_dashboard/app/src/presentation/public/views/politica_privacidad_view.dart';
export 'package:bot_dashboard/app/src/presentation/admin/views/account_view.dart';
export 'package:bot_dashboard/app/src/presentation/admin/views/chat_view.dart';
export 'package:bot_dashboard/app/src/presentation/admin/views/setting_view.dart';
export 'package:bot_dashboard/app/src/presentation/admin/views/suscription_view.dart';

// Shared
export 'package:bot_dashboard/app/src/shared/tab_menu.dart';
export 'package:bot_dashboard/app/src/shared/title_app.dart';
export 'package:bot_dashboard/app/src/shared/text_padding.dart';
export 'package:bot_dashboard/app/src/shared/player_content.dart';
export 'package:bot_dashboard/app/src/shared/elevated_buttons.dart';
export 'package:bot_dashboard/app/src/shared/custom_text_form_field.dart';

// Widgets
export 'package:bot_dashboard/app/src/presentation/admin/widgets/geminis_form.dart';
export 'package:bot_dashboard/app/src/presentation/admin/widgets/app_config_form.dart';

// Config
export 'package:bot_dashboard/app/src/config/app_config.dart';
