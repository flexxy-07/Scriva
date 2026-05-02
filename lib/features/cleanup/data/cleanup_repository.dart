import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:scriva/features/cleanup/domain/cleanup_mode.dart';

class CleanupRepository {
  final _dio = Dio();

  static const _baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-lite:generateContent';

  Future<String> cleanUp({
    required String rawTranscript,
    required CleanupMode mode,

  }) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    if(apiKey.isEmpty) throw Exception(
      'Gemini API key not configured'
    );


    final prompt = ''' 
      ${mode.prompt}

      RAW TRANSCRIPT : 

      """
    $rawTranscript
"""
    
    
    ''';

    final response = await _dio.post(
      '$_baseUrl?key=$apiKey',
      options: Options(
        headers: {
          'Content-Type' : 'application/json'
        },
        receiveTimeout: const Duration(seconds : 30),
      ),
      data: jsonEncode({
        'contents' : [
          {
            'parts' : [
              {
                'text' : prompt
              }
            ]
          }
        ]
      })
    )
  }
}