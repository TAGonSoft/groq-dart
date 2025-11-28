import 'role_message.dart';

/// A message in a chat conversation with the Groq API.
///
/// Messages are the building blocks of a conversation. Each message has a
/// [role] indicating who sent it (system, user, or assistant) and [content]
/// containing the actual text.
class GroqMessage {
  /// The role of the message author (system, user, or assistant).
  RoleMessage role;

  /// The text content of the message.
  String content;

  GroqMessage({
    required this.role,
    required this.content,
  });

  GroqMessage.fromJson(Map<String, dynamic> json)
      : role = RoleMessage.values.firstWhere(
            (element) => element.toString().split('.').last == json['role']),
        content = json['content'] as String;

  Map<String, dynamic> toJson() => {
        'role': role.name,
        'content': content,
      };
}
