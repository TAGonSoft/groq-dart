import 'api.dart';
import 'client.dart';
import 'model.dart';

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

  void setCustomInstructionsWith(String value) {
    _instructions = GroqMessage(role: RoleMessage.system, content: value);
  }

  void removeCustomInstructions() {
    _instructions = null;
  }

  Future<GroqResponse> sendMessage(String content) async {
    final message = GroqMessage(role: RoleMessage.user, content: content);
    _messages.add(message);
    final response = await _sendRequest();
    _messages.add(response.choices.first.message);
    return response;
  }

  void clearChat() {
    _messages = [];
  }

  Future<GroqResponse> _sendRequest() {
    final request = _generateRequest();
    return _apiClient.makeRequest(groqRequest: request);
  }

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
