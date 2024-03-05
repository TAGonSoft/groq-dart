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

export 'src/model.dart' show GroqResponse;
