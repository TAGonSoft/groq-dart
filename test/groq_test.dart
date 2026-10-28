import 'dart:io';

import 'package:groq/groq.dart';
import 'package:test/test.dart';

/// A chat completion as the Groq API returns it, with every optional block.
Map<String, dynamic> fullResponse() => {
      'id': 'chatcmpl-123',
      'object': 'chat.completion',
      'created': 1730000000,
      'model': 'llama-3.1-8b-instant',
      'system_fingerprint': 'fp_abc',
      'service_tier': 'on_demand',
      'choices': [
        {
          'index': 0,
          'message': {'role': 'assistant', 'content': 'Hello!'},
          'finish_reason': 'stop',
        },
      ],
      'usage': {
        'prompt_tokens': 12,
        'prompt_time': 0.0021,
        'completion_tokens': 3,
        'completion_time': 0.004,
        'total_tokens': 15,
        'total_time': 0.0061,
        'queue_time': 0.0315,
        'completion_tokens_details': {'reasoning_tokens': 0},
        'prompt_tokens_details': {'cached_tokens': 4},
      },
      'x_groq': {
        'id': 'req_01',
        'seed': 42,
        'usage': {'dram_cached_tokens': 0, 'sram_cached_tokens': 4},
      },
    };

void main() {
  group('GroqResponse.fromJson', () {
    test('parses a full response', () {
      final response = GroqResponse.fromJson(fullResponse());

      expect(response.id, 'chatcmpl-123');
      expect(response.choices.single.message.content, 'Hello!');
      expect(response.choices.single.message.role.name, 'assistant');
      expect(response.usage.totalTokens, 15);
      expect(response.usage.queueTime, closeTo(0.0315, 1e-9));
      expect(response.usage.promptTokensDetails?.cachedTokens, 4);
      expect(response.serviceTier, 'on_demand');
      expect(response.xGroq?.id, 'req_01');
      expect(response.xGroq?.usage?.sramCachedTokens, 4);
    });

    test('accepts whole-number timings and a missing x_groq block', () {
      final json = fullResponse()..remove('x_groq');
      (json['usage'] as Map<String, dynamic>)
        ..['prompt_time'] = 0
        ..['queue_time'] = 0
        ..remove('completion_tokens_details');

      final response = GroqResponse.fromJson(json);

      expect(response.usage.promptTime, 0.0);
      expect(response.usage.queueTime, 0.0);
      expect(response.usage.completionTokensDetails, isNull);
      expect(response.xGroq, isNull);
    });

    test('accepts a null message content (tool calls)', () {
      final json = fullResponse();
      ((json['choices'] as List).single as Map<String, dynamic>)['message'] = {
        'role': 'assistant',
        'content': null,
      };

      final response = GroqResponse.fromJson(json);

      expect(response.choices.single.message.content, '');
    });
  });

  test('toJson keeps the API field names', () {
    final json = GroqResponse.fromJson(fullResponse()).toJson();
    final usage = json['usage'] as Map<String, dynamic>;

    expect(usage['queue_time'], closeTo(0.0315, 1e-9));
    final choice = (json['choices'] as List).single as Map<String, dynamic>;
    expect(choice['message'], {'role': 'assistant', 'content': 'Hello!'});
    expect((json['x_groq'] as Map<String, dynamic>)['id'], 'req_01');
    expect(json['service_tier'], 'on_demand');
  });

  // Calls the real API. Runs only when GROQ_API_KEY is set:
  //   GROQ_API_KEY=... dart test
  test(
    'live: sends a message and parses the answer',
    () async {
      final groq = Groq(
        apiKey: Platform.environment['GROQ_API_KEY']!,
        configuration:
            Configuration(model: 'llama-3.1-8b-instant', temperature: 0),
      )..startChat();

      final response = await groq.sendMessage('Reply with the single word OK.');

      expect(response.choices, isNotEmpty);
      expect(response.choices.first.message.content, isNotEmpty);
      expect(response.usage.totalTokens, greaterThan(0));
    },
    skip: Platform.environment['GROQ_API_KEY'] == null
        ? 'set GROQ_API_KEY to run against the Groq API'
        : false,
  );
}
