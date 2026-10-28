import '../groq_message.dart';

//
// The message options received from Groq API
//

class GroqChoices {
  int index;
  GroqMessage message;

  GroqChoices({
    required this.index,
    required this.message,
  });

  factory GroqChoices.fromJson(Map<String, dynamic> json) {
    return GroqChoices(
      index: json['index'] as int,
      message: GroqMessage.fromJson(json['message'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'index': index,
        'message': message.toJson(),
      };
}
