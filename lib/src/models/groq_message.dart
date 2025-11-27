//
// The message object received or sended to or from Groq API
//

import 'role_message.dart';

class GroqMessage {
  RoleMessage role;
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
