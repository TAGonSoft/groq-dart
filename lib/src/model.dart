enum GroqModel {
  meta,
  mixtral,
}

enum RoleMessage {
  system,
  user,
  assistant,
}

class GroqRequest {
  List<GroqMessage> messages;
  String model;
  double temperature;
  int maxTokens;
  double topP;
  bool stream;
  String? stop;

  GroqRequest({
    required this.messages,
    required this.model,
    required this.temperature,
    required this.maxTokens,
    required this.topP,
    required this.stream,
    required this.stop,
  });

  factory GroqRequest.fromJson(Map<String, dynamic> json) {
    return GroqRequest(
      messages: List<GroqMessage>.from(
          json['messages'].map((message) => GroqMessage.fromJson(message))),
      model: json['model'],
      temperature: json['temperature'],
      maxTokens: json['max_tokens'],
      topP: json['top_p'],
      stream: json['stream'],
      stop: json['stop'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messages': messages.map((message) => message.toJson()).toList(),
      'model': model,
      'temperature': temperature,
      'max_tokens': maxTokens,
      'top_p': topP,
      'stream': stream,
      'stop': stop,
    };
  }
}

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
      id: json['id'],
      object: json['object'],
      created: json['created'],
      model: json['model'],
      choices: List<GroqChoices>.from(
        json['choices'].map(
          (choice) => GroqChoices.fromJson(choice),
        ),
      ),
      usage: GroqUsage.fromJson(json['usage']),
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

class GroqChoices {
  int index;
  GroqMessage message;

  GroqChoices({
    required this.index,
    required this.message,
  });

  factory GroqChoices.fromJson(Map<String, dynamic> json) {
    return GroqChoices(
      index: json['index'],
      message: GroqMessage.fromJson(json['message']),
    );
  }

  Map<String, dynamic> toJson() => {
        'index': index,
        'message': message,
      };
}

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
