// Define an enum for the different log levels
import 'dart:developer';

enum Level { debug, info, warning, error, alien }

// Define a logDebug function that logs messages at the specified level
// log different colors
void logDebug(String message, {Level level = Level.info}) {
  // Define ANSI escape codes for different colors
  const String resetColor = '\x1B[0m';
  const String redColor = '\x1B[31m'; // Red
  const String greenColor = '\x1B[32m'; // Green
  const String yellowColor = '\x1B[33m'; // Yellow
  const String cyanColor = '\x1B[36m'; // Cyan

  // Get the current time in hours, minutes, and seconds
  final now = DateTime.now();
  final timeString =
      '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

  try {
    String logMessage;
    switch (level) {
      case Level.debug:
        logMessage = '$cyanColor[DEBUG][$timeString] $message$resetColor';
        break;
      case Level.info:
        logMessage = '$greenColor[INFO][$timeString] $message$resetColor';
        break;
      case Level.warning:
        logMessage = '$yellowColor[WARNING][$timeString] $message $resetColor';
        break;
      case Level.error:
        logMessage = '$redColor[ERROR][$timeString] $message $resetColor';
        break;
      case Level.alien:
        logMessage = '$redColor[ALIEN][$timeString] $message $resetColor';
        break;
    }
    log(logMessage);
  } catch (e) {
    log(e.toString());
  }
}
