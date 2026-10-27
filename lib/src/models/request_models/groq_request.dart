//
// The request object from Groq API
//
import '../../../groq.dart';
import '../groq_message.dart';

class GroqRequest {
  List<GroqMessage> messages;
  Configuration configuration;

  GroqRequest({
    required this.messages,
    required this.configuration,
  });

  Map<String, dynamic> toJson() {
    return {
      'messages': messages.map((message) => message.toJson()).toList(),
      ...configuration.toNonNullMap(),
    };
  }
}
