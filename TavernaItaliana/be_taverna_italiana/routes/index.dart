import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    return Response.json(body: 'Server Started!');
  } catch (e) {
    return Response(statusCode: 500, body: 'Errore: $e');
  }
}
