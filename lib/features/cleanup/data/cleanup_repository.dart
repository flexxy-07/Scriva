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
        ],
        'generationConfig' : {
          'temperature' : 0.3,
          'maxOutputTokens' : 2040,
        }
      })
    );

    final candidates = response.data['candidates'] as List?;

    if(candidates == null || candidates.isEmpty){
      throw Exception(
        'No response from the Gemini'
      );
    }

    final text = candidates[0]['content']['parts'][0]['text'] as String?;

    if(text == null || text.trim().isEmpty){
      throw Exception(
        'Empty response from Gemini'
      );
    }

    return text.trim();
  }
}