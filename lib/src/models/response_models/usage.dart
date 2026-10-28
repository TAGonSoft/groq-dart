//
// The statistics recevied from Groq API with each response
//
class GroqUsage {
  int promptTokens;
  // Time spent processing input tokens
  double promptTime;

  // Number of tokens in the generated completion.
  int completionTokens;

  // Time spent generating tokens
  double completionTime;

  // Total number of tokens used in the request (prompt + completion).
  int totalTokens;

  // Completion time and prompt time combined
  double totalTime;

  // Time the requests was spent queued
  double queueTime;

  // Breakdown of tokens in the completion.
  GroqUsageCompletionTokensDetails? completionTokensDetails;

  // Breakdown of tokens in the prompt.
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
        promptTime = (json['prompt_time'] as num?)?.toDouble() ?? 0,
        completionTokens = json['completion_tokens'] as int,
        completionTime = (json['completion_time'] as num?)?.toDouble() ?? 0,
        totalTokens = json['total_tokens'] as int,
        totalTime = (json['total_time'] as num?)?.toDouble() ?? 0,
        queueTime = (json['queue_time'] as num?)?.toDouble() ?? 0,
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
        'total_time': totalTime,
        'queue_time': queueTime,
      };
}

class GroqUsageCompletionTokensDetails {
  // Number of tokens used for reasoning (for reasoning models).
  final int reasoningTokens;

  GroqUsageCompletionTokensDetails({required this.reasoningTokens});

  factory GroqUsageCompletionTokensDetails.fromJson(Map<String, dynamic> json) {
    return GroqUsageCompletionTokensDetails(
      reasoningTokens: (json['reasoning_tokens'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'reasoning_tokens': reasoningTokens,
      };
}

class GroqPromptTokensDetails {
  // Number of tokens that were cached and reused
  final int cachedTokens;

  GroqPromptTokensDetails({required this.cachedTokens});

  factory GroqPromptTokensDetails.fromJson(Map<String, dynamic> json) {
    return GroqPromptTokensDetails(
      cachedTokens: (json['cached_tokens'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'cached_tokens': cachedTokens,
      };
}
