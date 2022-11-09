import 'package:flutter/material.dart';
import 'package:pokemon_app/app/app.dart';
import 'package:pokemon_app/bootstrap.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(() => const App());
}
