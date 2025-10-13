//
// Type of massage roles
//
import 'api.dart';

enum RoleMessage {
  system,
  user,
  assistant,
}

//
// The request object from Groq API
//
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

//
// The response object received from Groq API
//
class GroqResponse {
  String id;
  String object;
  int created;
  String model;
  List<GroqChoices> choices;
  GroqUsage usage;

  GroqResponse({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
  });

  factory GroqResponse.fromJson(Map<String, dynamic> json) {
    return GroqResponse(
      id: json['id'] as String,
      object: json['object'] as String,
      created: json['created'] as int,
      model: json['model'] as String,
      choices: List<GroqChoices>.from(
        (json['choices'] as List<dynamic>).map(
          (choice) => GroqChoices.fromJson(choice as Map<String, dynamic>),
        ),
      ),
      usage: GroqUsage.fromJson(json['usage'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'object': object,
      'created': created,
      'model': model,
      'choices': choices.map((choice) => choice.toJson()).toList(),
      'usage': usage.toJson(),
    };
  }
}

//
// The message object received or sended to or from Groq API
//
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
        'message': message,
      };
}

//
// The statistics recevied from Groq API with each response
//
class GroqUsage {
  int promptTokens;
  double promptTime;
  int completionTokens;
  double completionTime;
  int totalTokens;
  double totalTime;

  GroqUsage({
    required this.promptTokens,
    required this.promptTime,
    required this.completionTokens,
    required this.completionTime,
    required this.totalTokens,
    required this.totalTime,
  });

  GroqUsage.fromJson(Map<String, dynamic> json)
      : promptTokens = json['prompt_tokens'] as int,
        promptTime = json['prompt_time'] as double,
        completionTokens = json['completion_tokens'] as int,
        completionTime = json['completion_time'] as double,
        totalTokens = json['total_tokens'] as int,
        totalTime = json['total_time'] as double;

  Map<String, dynamic> toJson() => {
        'prompt_tokens': promptTokens,
        'prompt_time': promptTime,
        'completion_tokens': completionTokens,
        'completion_time': completionTime,
        'total_tokens': totalTokens,
        'total_time': totalTime
      };
}
