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
  double queueTime;
  GroqUsageCompletionTokensDetails? completionTokensDetails;
  GroqPromptTokensDetails? promptTokensDetails;

  GroqUsage({
    required this.promptTokens,
    required this.promptTime,
    required this.completionTokens,
    required this.completionTime,
    required this.totalTokens,
    required this.totalTime,
    required this.queueTime,
    this.completionTokensDetails,
    this.promptTokensDetails,
  });

  GroqUsage.fromJson(Map<String, dynamic> json)
      : promptTokens = json['prompt_tokens'] as int,
        promptTime = json['prompt_time'] as double,
        completionTokens = json['completion_tokens'] as int,
        completionTime = json['completion_time'] as double,
        totalTokens = json['total_tokens'] as int,
        totalTime = json['total_time'] as double,
        queueTime = json['queue_time'] as double,
        completionTokensDetails = json['completion_tokens_details'] != null
            ? GroqUsageCompletionTokensDetails.fromJson(
                json['completion_tokens_details'] as Map<String, dynamic>)
            : null,
        promptTokensDetails = json['prompt_tokens_details'] != null
            ? GroqPromptTokensDetails.fromJson(
                json['prompt_tokens_details'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'prompt_tokens': promptTokens,
        'prompt_time': promptTime,
        'completion_tokens': completionTokens,
        'completion_time': completionTime,
        'total_tokens': totalTokens,
        'total_time': totalTime
      };
}

class GroqUsageCompletionTokensDetails {
  final int reasoningTokens;

  GroqUsageCompletionTokensDetails({required this.reasoningTokens});

  factory GroqUsageCompletionTokensDetails.fromJson(Map<String, dynamic> json) {
    return GroqUsageCompletionTokensDetails(
      reasoningTokens: json['reasoning_tokens'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'reasoning_tokens': reasoningTokens,
      };
}

class GroqPromptTokensDetails {
  final int cachedTokens;

  GroqPromptTokensDetails({required this.cachedTokens});

  factory GroqPromptTokensDetails.fromJson(Map<String, dynamic> json) {
    return GroqPromptTokensDetails(
      cachedTokens: json['cached_tokens'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'documents_tokens': cachedTokens,
      };
}
