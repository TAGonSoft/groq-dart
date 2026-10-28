/// Groq Generative AI
/// The Groq AI SDK for Dart allows developers to use Large Language Models (LLMs) to build language applications.
/// final groq = Groq(apiKey: const String.fromEnvironment('groqApiKey'));
///
/// groq.startChat();
///
/// try {
///
/// GroqResponse response = await groq.sendMessage(text);
///
/// print(response.choices.first.message.content)
///
/// } on GroqException catch (error) {
///     print(error.message)
/// }
library;

export 'src/api.dart' show Configuration;
export 'src/error.dart'
    show
        GroqException,
        BadRequestError,
        AuthenticationError,
        PermissionDeniedError,
        NotFoundError,
        UnprocessableEntityError,
        RateLimitError,
        InternalServerError,
        APIConnectionError;
export 'src/init.dart' show Groq;
export 'src/models/request_models/compound_custom.dart'
    show
        CompoundCustom,
        CompoundCustomModels,
        CompoundCustomTools,
        WolframSettingsConfiguration;
export 'src/models/request_models/response_format.dart' show ResponseFormat;
export 'src/models/request_models/search_settings.dart' show SearchSettings;
export 'src/models/request_models/tool.dart' show Tool;
export 'src/models/request_models/tool_choice.dart' show ToolChoice;
export 'src/models/response_models/mcp_list_tools.dart'
    show McpListTools, McpTool;
export 'src/models/response_models/response.dart' show GroqResponse;
