import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:path/path.dart' as pathio;

Future<Response> onRequest(RequestContext context) async {
  try {
    final currentDir = Directory.current;
    final filePath =
        pathio.join(currentDir.path, 'public', 'json', 'recipes.json');
    final file = File(filePath);
    final fileExists = file.existsSync();
    if (!fileExists) {
      return Response(statusCode: 404, body: 'Recipes file not found');
    }

    final jsonString = await file.readAsString();

    final jsonData = jsonDecode(jsonString);
    // To emulate a delay of 2 seconds
    await Future<void>.delayed(const Duration(seconds: 2));

    return Response.json(body: jsonData);
  } catch (e) {
    return Response(statusCode: 500, body: 'Errore: $e');
  }
}
