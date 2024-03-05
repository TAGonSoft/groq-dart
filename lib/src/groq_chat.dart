import 'api.dart';
import 'client.dart';
import 'model.dart';

/// A back-and-forth chat with a generative model.
///
/// Records messages sent and received in [_messages]. The history will always
/// record the content until the user clean the chat message.
class GroqChat {
  late ApiClient _apiClient;
  late Configuration _configuration;
  List<GroqMessage> _messages = [];
  GroqMessage? _instructions;

  GroqChat({
    required ApiClient apiClient,
    required GroqModel model,
  }) {
    _apiClient = apiClient;
    _configuration = Configuration(model: model);
  }

  // Set instruction to the model
  void setCustomInstructionsWith(String value) {
    _instructions = GroqMessage(role: RoleMessage.system, content: value);
  }

  // Remove instruction form the model
  void removeCustomInstructions() {
    _instructions = null;
  }

  // Set instruction to the model
  Future<GroqResponse> sendMessage(String content) async {
    final message = GroqMessage(role: RoleMessage.user, content: content);
    _messages.add(message);
    final response = await _sendRequest();
    _messages.add(response.choices.first.message);
    return response;
  }

  // Clear the messages from the chat
  void clearChat() {
    _messages = [];
  }

  // Send a request to Groq API
  Future<GroqResponse> _sendRequest() {
    final request = _generateRequest();
    return _apiClient.makeRequest(groqRequest: request);
  }

  // Create a request with all details (instructions, messages, configurations)
  GroqRequest _generateRequest() {
    final message = _messages;

    if (_instructions != null) {
      _messages.insert(0, _instructions!);
    }

    return GroqRequest(
      messages: message,
      model: _configuration.modelName,
      temperature: _configuration.temperature,
      maxTokens: _configuration.maxTokens,
      topP: _configuration.topP,
      stream: _configuration.stream,
      stop: _configuration.stop,
    );
  }
}
