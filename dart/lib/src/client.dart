import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';

/// Validation rule for a parameter.
class ValidationRule {
  final String type;
  final bool required;
  final num? min;
  final num? max;
  final int? minLength;
  final int? maxLength;
  final String? format;
  final List<String>? enumValues;

  const ValidationRule({
    required this.type,
    required this.required,
    this.min,
    this.max,
    this.minLength,
    this.maxLength,
    this.format,
    this.enumValues,
  });
}

/// Exception thrown when parameter validation fails.
class NewsValidationException implements Exception {
  final List<String> errors;

  NewsValidationException(this.errors);

  @override
  String toString() => 'NewsValidationException: ${errors.join("; ")}';
}

/// Format validation patterns.
final _formatPatterns = {
  'email': RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$'),
  'url': RegExp(r'^https?://.+'),
  'ip': RegExp(r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$'),
  'date': RegExp(r'^\d{4}-\d{2}-\d{2}$'),
  'hexColor': RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$'),
};

/// World News API client.
///
/// For more information, visit: https://apiverve.com/marketplace/news?utm_source=dart&utm_medium=referral&utm_content=readme
///
/// Parameters:
/// * [category] - Only stories on this topic. A story is in every topic its headline and summary name, not only its feed's section.
/// * [country] - Only stories about this country, from any outlet: an ISO 3166 code or English name, for example JP or Japan. [maxLength: 60]
/// * [edition] - Only stories run by outlets based in this country: what its press is covering, in the languages it writes in. See list=editions.
/// * [language] - Only stories in this language. Defaults to English, or with edition to the languages that edition's press writes in. Stories are never translated.
/// * [sort] - top ranks stories by how many outlets carry them, favouring the last 12 hours; latest is newest first.
/// * [q] - Only stories whose headlines or summaries contain every word given, in any case. [maxLength: 100]
/// * [since] - Only stories published at or after this date or date-time (ISO 8601), for example 2026-10-01 or 2026-10-01T14:00:00Z. [maxLength: 30, format: date]
/// * [limit] - Maximum number of stories to return: up to 10 on the free plan, 50 on paid plans. [min: 1]
class NewsClient {
  final String apiKey;
  final String baseUrl;
  final http.Client _httpClient;

  /// Validation rules for parameters.
  static final Map<String, ValidationRule> _validationRules = <String, ValidationRule>{
    'category': ValidationRule(type: 'string', required: false),
    'country': ValidationRule(type: 'string', required: false, maxLength: 60),
    'edition': ValidationRule(type: 'string', required: false),
    'language': ValidationRule(type: 'string', required: false),
    'sort': ValidationRule(type: 'string', required: false),
    'q': ValidationRule(type: 'string', required: false, maxLength: 100),
    'since': ValidationRule(type: 'string', required: false, maxLength: 30, format: 'date'),
    'limit': ValidationRule(type: 'integer', required: false, min: 1),
  };

  NewsClient(this.apiKey, {
    this.baseUrl = 'https://api.apiverve.com/v1/news',
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  /// Validates parameters against defined rules.
  /// Throws [NewsValidationException] if validation fails.
  void _validateParams(Map<String, dynamic> params) {
    final errors = <String>[];

    for (final entry in _validationRules.entries) {
      final paramName = entry.key;
      final rule = entry.value;
      final value = params[paramName];

      // Check required
      if (rule.required && (value == null || (value is String && value.isEmpty))) {
        errors.add('Required parameter [$paramName] is missing');
        continue;
      }

      if (value == null) continue;

      // Type-specific validation
      if (rule.type == 'integer' || rule.type == 'number') {
        final numValue = value is num ? value : num.tryParse(value.toString());
        if (numValue == null) {
          errors.add('Parameter [$paramName] must be a valid ${rule.type}');
          continue;
        }
        if (rule.min != null && numValue < rule.min!) {
          errors.add('Parameter [$paramName] must be at least ${rule.min}');
        }
        if (rule.max != null && numValue > rule.max!) {
          errors.add('Parameter [$paramName] must be at most ${rule.max}');
        }
      } else if (rule.type == 'string' && value is String) {
        if (rule.minLength != null && value.length < rule.minLength!) {
          errors.add('Parameter [$paramName] must be at least ${rule.minLength} characters');
        }
        if (rule.maxLength != null && value.length > rule.maxLength!) {
          errors.add('Parameter [$paramName] must be at most ${rule.maxLength} characters');
        }
        if (rule.format != null && _formatPatterns.containsKey(rule.format)) {
          if (!_formatPatterns[rule.format]!.hasMatch(value)) {
            errors.add('Parameter [$paramName] must be a valid ${rule.format}');
          }
        }
      }

      // Enum validation
      if (rule.enumValues != null && rule.enumValues!.isNotEmpty) {
        if (!rule.enumValues!.contains(value.toString())) {
          errors.add('Parameter [$paramName] must be one of: ${rule.enumValues!.join(", ")}');
        }
      }
    }

    if (errors.isNotEmpty) {
      throw NewsValidationException(errors);
    }
  }

  /// Execute a request to the World News API.
  ///
  /// Parameters are validated before sending the request.
  Future<NewsResponse> execute(Map<String, dynamic> params) async {
    // Validate parameters
    _validateParams(params);
    if (apiKey.isEmpty) {
      throw NewsException('API key is required. Get your API key at: https://apiverve.com');
    }

    try {
      final uri = Uri.parse(baseUrl).replace(
        queryParameters: params.map((key, value) => MapEntry(key, value.toString())),
      );

      final response = await _httpClient.get(
        uri,
        headers: {
          'x-api-key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return NewsResponse.fromJson(json);
      } else if (response.statusCode == 401) {
        throw NewsException('Invalid API key');
      } else if (response.statusCode == 404) {
        throw NewsException('Resource not found');
      } else {
        throw NewsException('API error: ${response.statusCode}');
      }
    } catch (e) {
      if (e is NewsException) rethrow;
      throw NewsException('Request failed: $e');
    }
  }


  /// Close the HTTP client.
  void close() {
    _httpClient.close();
  }
}

/// Exception thrown by the World News API client.
class NewsException implements Exception {
  final String message;

  NewsException(this.message);

  @override
  String toString() => 'NewsException: $message';
}
