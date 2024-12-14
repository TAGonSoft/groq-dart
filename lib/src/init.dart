import 'api.dart';
import 'client.dart';
import 'groq_chat.dart';
import 'model.dart';

//
// Groq Main Interface
//
final class Groq {
  ApiClient apiClient;
  String model;
  Configuration? configuration;
  late GroqChat _chat;

  Groq._withApiClient({
    required this.apiClient,
    required this.model,
    this.configuration,
  });

  //
  // Create a Groq objects
  //
  factory Groq({
    required String apiKey,
    required String model,
    Configuration? configuration,
  }) =>
      Groq._withApiClient(
        apiClient: ApiClient(apiKey: apiKey),
        model: model,
        configuration: configuration,
      );

  // Start the chat model
  void startChat() {
    _chat = GroqChat(apiClient: apiClient, model: model);
  }

  // Set instructions to the model of the chat
  void setCustomInstructionsWith(String instructions) {
    _chat.setCustomInstructionsWith(instructions);
  }

  // Remove the custom instruction from the chat
  void removeCustomInstructions() {
    _chat.removeCustomInstructions();
  }

  // Clear all messages from the chat
  void clearChat() {
    _chat.clearChat();
  }

  // Send a message tot the chat
  Future<GroqResponse> sendMessage(String message) {
    return _chat.sendMessage(message);
  }
}
