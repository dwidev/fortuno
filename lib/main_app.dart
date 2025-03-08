import 'package:fortuno/app.dart';
import 'package:fortuno/core/core.dart';
import 'package:fortuno/core/environtments/env_enum.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/firebase/firebase.dart';

Future<void> mainApp(Environtment environtment) async {
  WidgetsFlutterBinding.ensureInitialized();

  await intializeFirebasApp(environtment);

  Supabase.initialize(
    url: 'https://qzyzhzmmmzngcytqikhq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF6eXpoem1tbXpuZ2N5dHFpa2hxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDEyOTc5NTIsImV4cCI6MjA1Njg3Mzk1Mn0.zRzXEJpTRH-1xDh3-zTDX8tlB9jNw2GId9O9ZvpIvXY',
  );

  runApp(App(environtment: environtment));
}
