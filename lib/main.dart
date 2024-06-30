import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:health/main_app.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MainApp());
}
