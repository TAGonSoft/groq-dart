import 'api.dart';
import 'client.dart';
import 'groq_chat.dart';
import 'model.dart';

final class Groq {
  ApiClient apiClient;
  GroqModel model;
  Configuration? configuration;
  late GroqChat _chat;

  Groq._withApiClient({
    required this.apiClient,
    required this.model,
    this.configuration,
  });

  factory Groq({
    required String apiKey,
    GroqModel model = GroqModel.meta,
    Configuration? configuration,
  }) =>
      Groq._withApiClient(
        apiClient: ApiClient(apiKey: apiKey),
        model: model,
        configuration: configuration,
      );

  void setCustomInstructionsWith(String instructions) {
    _chat.setCustomInstructionsWith(instructions);
  }

  void startChat() {
    _chat = GroqChat(apiClient: apiClient, model: model);
  }

  void removeCustomInstructions() {
    _chat.removeCustomInstructions();
  }

  void clearChat() {
    _chat.clearChat();
  }

  Future<GroqResponse> sendMessage(String message) {
    return _chat.sendMessage(message);
  }
}
