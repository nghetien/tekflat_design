import 'package:flutter_dotenv/flutter_dotenv.dart';

class TekLoadEnv {
  const TekLoadEnv._();

  static Future init({String? envFile}) async => dotenv.load(fileName: envFile ?? '.env');

  static String get({
    required String key,
    String valueDefault = '',
  }) =>
      dotenv.get(key, fallback: valueDefault);
}
