// Groq API Header Keys
import 'models/request_models/compound_custom.dart';
import 'models/request_models/response_format.dart';
import 'models/request_models/search_settings.dart';
import 'models/request_models/stream_options.dart';
import 'models/request_models/tool.dart';
import 'models/request_models/tool_choice.dart';

final class ApiHeaderKeys {
  static const String authorization = 'Authorization';
  static const String contentType = 'Content-Type';
}

// Groq API Header Values
final class ApiHeaderValues {
  static const String applicationJson = 'application/json';
  static String bearer(String key) {
    return 'Bearer $key';
  }
}

// Groq API Configuration model
final class Configuration {
  /// The model which will generate the completion.
  /// Some models are suitable for natural language
  /// tasks, others specialize in code.
  final String model;

  /// Whether to enable citations in the response.
  /// When enabled, the model will include citations for information
  ///  retrieved from provided documents or web searches.
  final bool? citationOptions;

  // If set to true, groq will return called tools without
  // validating that the tool is present in request.tools.
  // tool_choice=required/none will still be enforced, but
  // the request cannot require a specific tool be used.
  final bool? disableToolValidation;

  // Custom configuration of models and tools for Compound.
  final CompoundCustom? compoundCustom;

  // A list of documents to provide context for the conversation.
  // Each document contains text that can be referenced by the model.
  final List<String>? documents;

  // Whether to enable parallel function calling during tool use.
  final bool? parallelToolCalls;

  // Allowed values: none, default, low, medium, high
  // qwen3 models support the following values Set to 'none' to disable reasoning.
  // Set to 'default' or null to let Qwen reason.openai/gpt-oss-20b and
  // openai/gpt-oss-120b support 'low', 'medium', or 'high'. 'medium' is the default value.
  final String? reasoningEffort;

  // Allowed values: hidden, raw, parsed
  // Specifies how to output reasoning tokens This field is mutually exclusive with
  // include_reasoning.
  final String? reasoningFormat;

  /// An object specifying the format that the model must output.
  ///  Setting to { "type": "json_schema", "json_schema": {...} } enables
  /// Structured Outputs which ensures the model will match your supplied
  /// JSON schema. json_schema response format is only available
  ///  on supported models.
  /// Setting to { "type": "json_object" } enables the older JSON mode,
  ///  which ensures the message the model generates is valid JSON.
  /// Using json_schema is preferred for models that support it.
  final ResponseFormat? responseFormat;

  /// Settings for web search functionality when the model
  /// uses a web search tool.
  final SearchSettings? searchSettings;

  /// Controls randomness: lowering results in less
  /// random completions. As the temperature approaches
  /// zero, the model will become deterministic and repetitive.
  final double? temperature;

  // The maximum number of tokens that can be generated in the chat completion.
  // The total length of input tokens and generated tokens is limited by the model's context length.
  final int? maxCompletionTokens;

  /// Controls diversity via nucleus sampling: 0.5 means
  /// half of all likelihood-weighted options are considered.
  final double? topP;

  // A unique identifier representing your end-user, which can help us monitor and
  // detect abuse.
  final String? user;

  /// Set if the request is via stream on request
  final bool? stream;

  /// Options for streaming response. Only set this when you set stream: true.
  final StreamOptions? streamOptions;

  // If specified, our system will make a best effort to sample deterministically,
  // such that repeated requests with the same seed and parameters should return the
  // same result. Determinism is not guaranteed, and you should refer to
  // the system_fingerprint response parameter to monitor changes in the backend.
  final int? seed;

  // Allowed values: auto, on_demand, flex, performance, null
  // The service tier to use for the request. Defaults to on_demand.
  //
  // auto will automatically select the highest tier available within the rate limits of your organization.
  // flex uses the flex tier, which will succeed or fail quickly.
  final String? serviceTier;

  /// A stop sequence is a predefined or user-specified text string that
  /// signals an AI to stop generating content, ensuring its responses remain
  /// focused and concise. Examples include punctuation marks and markers
  /// like "`[end]`".
  final String? stop;

  // Whether to include reasoning in the response. If true, the response will
  // include a reasoning field. If false, the model's reasoning will not be included
  // in the response. This field is mutually exclusive with reasoning_format.
  final bool? includeReasoning;

  // Controls which (if any) tool is called by the model.
  // Default is "none" when no tools are present, "auto" when tools are present.
  final ToolChoice? toolChoice;

  // A list of tools the model may call. Currently, only functions are supported.
  // Use this to provide a list of functions the model may generate JSON inputs for.
  // A max of 128 functions are supported.
  final List<Tool>? tools;

  Configuration({
    required this.model,
    this.citationOptions,
    this.disableToolValidation,
    this.compoundCustom,
    this.documents,
    this.parallelToolCalls,
    this.reasoningEffort,
    this.reasoningFormat,
    this.responseFormat,
    this.searchSettings,
    this.streamOptions,
    this.temperature,
    this.maxCompletionTokens,
    this.topP,
    this.user,
    this.stream,
    this.seed,
    this.serviceTier,
    this.stop,
    this.includeReasoning,
    this.toolChoice,
    this.tools,
  });

  Map<String, dynamic> toNonNullMap() {
    final map = <String, dynamic>{};
    map['model'] = model;

    if (citationOptions != null) {
      map['citation_options'] = citationOptions;
    }

    if (compoundCustom != null) {
      final compoundMap = compoundCustom!.toNonNullMap();
      if (compoundMap.isNotEmpty) {
        map['compound_custom'] = compoundMap;
      }
    }

    if (disableToolValidation != null) {
      map['disable_tool_validation'] = disableToolValidation;
    }

    if (documents != null) {
      map['documents'] = documents;
    }

    if (parallelToolCalls != null) {
      map['parallel_tool_calls'] = parallelToolCalls;
    }

    if (reasoningEffort != null) {
      map['reasoning_effort'] = reasoningEffort;
    }

    if (reasoningFormat != null) {
      map['reasoning_format'] = reasoningFormat;
    }

    if (responseFormat != null) {
      map['response_format'] = responseFormat!.toNonNullMap();
    }

    if (searchSettings != null) {
      map['search_settings'] = searchSettings!.toNonNullMap();
    }

    if (temperature != null) {
      map['temperature'] = temperature;
    }

    if (maxCompletionTokens != null) {
      map['max_completion_tokens'] = maxCompletionTokens;
    }

    if (topP != null) {
      map['top_p'] = topP;
    }

    if (user != null) {
      map['user'] = user;
    }

    if (stream != null) {
      map['stream'] = stream;
    }

    if (seed != null) {
      map['seed'] = seed;
    }

    if (serviceTier != null) {
      map['service_tier'] = serviceTier;
    }

    if (stop != null) {
      map['stop'] = stop;
    }

    if (includeReasoning != null) {
      map['include_reasoning'] = includeReasoning;
    }

    if (toolChoice != null) {
      map['tool_choice'] = toolChoice!.toNonNullMap();
    }

    if (tools != null) {
      map['tools'] = tools!.map((tool) => tool.toNonNullMap()).toList();
    }

    return map;
  }
}
