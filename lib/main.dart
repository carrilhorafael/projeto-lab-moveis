import 'package:flutter/material.dart';

import 'app.dart';
import 'firebase_init.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FirebaseInit(App()));
}
