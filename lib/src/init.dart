import 'package:groq/src/api.dart';
import 'package:groq/src/client.dart';
import 'package:groq/src/groq_chat.dart';
import 'package:groq/src/model.dart';

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
    required apiKey,
    GroqModel model = GroqModel.meta,
    Configuration? configuration,
  }) =>
      Groq._withApiClient(
        apiClient: ApiClient(apiKey: apiKey),
        model: model,
        configuration: configuration,
      );

  setCustomInstructionsWith(String instructions) {
    _chat.setCustomInstructionsWith(instructions);
  }

  startChat() {
    _chat = GroqChat(apiClient: apiClient, model: model);
  }

  removeCustomInstructions() {
    _chat.removeCustomInstructions();
  }

  clearChat() {
    _chat.clearChat();
  }

  Future<GroqResponse> sendMessage(String message) {
    return _chat.sendMessage(message);
  }
}
