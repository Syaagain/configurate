import 'package:flutter/material.dart';
import 'app.dart';
import '/core/dependyinjection/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependencies
  await di.init();
  
  runApp(MyApp());
}