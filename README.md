# Groq Dart Package

Built and maintained by [TAGonSoft](https://tagonsoft.com), an AI-native development and AI integrations studio. Listed in Groq's official [community libraries](https://console.groq.com/docs/libraries).

## Overview
This Dart package provides a simple and elegant integration with the Groq AI API, allowing developers to easily incorporate conversational AI capabilities into their Flutter applications.

## Features
- Simple API key configuration
- Support for multiple Groq AI models
- Easy message sending and chat management
- Custom system instructions
- Error handling
- Flutter-friendly UI components

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  groq: ^1.2.0
```

Then run:
```bash
flutter pub get
```

## Usage

### 1. API Key Configuration

You can set your Groq API key when running the app using:
```bash
flutter run --dart-define=groqApiKey='YOUR_GROQ_API_KEY'
```

### 2. Basic Example

```dart
import 'package:groq/groq.dart';

// Initialize Groq client
final groqConfiguration = Configuration(
  model: "qwen/qwen3-32b", // Set a different model
  temperature: 0.7,
  seed: 10,
);

/// flutter run --dart-define=groqApiKey='Your Api Key'
late final _groq = Groq(
  apiKey: const String.fromEnvironment('groqApiKey'),
  configuration: groqConfiguration,
);

// Start a chat session
groq.startChat();

// Send a message
GroqResponse response = await groq.sendMessage("Hello, how are you?");
print(response.choices.first.message.content);
```

### 3. Custom System Instructions

You can set custom system instructions to guide the AI's behavior:

```dart
// Set custom instructions for the chat
groq.setCustomInstructionsWith(
  "You are a helpful assistant who always responds in a friendly, concise manner. " +
  "Use casual language and provide clear, direct answers."
);

// Now subsequent messages will follow these instructions
GroqResponse response = await groq.sendMessage("Tell me about AI");
```

### 4. Complete Flutter Chat Example

```dart
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  final ScrollController _scrollController = ScrollController();

  final groqConfiguration = Configuration(
    model: "qwen/qwen3-32b", // Set a different model
    temperature: 0.7,
    seed: 10,
  );

  /// flutter run --dart-define=groqApiKey='Your Api Key'
  late final _groq = Groq(
    apiKey: const String.fromEnvironment('groqApiKey'),
    configuration: groqConfiguration,
  );

  @override
  void initState() {
    super.initState();
    _groq.startChat();
  }

  void _handleSubmitted(String text) async {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      isUserMessage: true,
    );
    setState(() {
      _messages.add(message);
    });

    _scrollToBottomWithDelay(
      const Duration(milliseconds: 200),
    );

    _sendMessage(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GroqChat'),
        actions: [_buildClearChatButton()],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                itemBuilder: (_, int index) => _messages[index],
              ),
            ),
            const Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClearChatButton() {
    return IconButton(
      onPressed: () {
        _groq.clearChat();
      },
      icon: const Icon(Icons.delete),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  hintText: 'Send a message',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }

  _scrollToBottomWithDelay(Duration delay) async {
    await Future.delayed(delay);
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  _sendMessage(String text) async {
    try {
      GroqResponse response = await _groq.sendMessage(text);

      ChatMessage responseMessage = ChatMessage(
        text: response.choices.first.message.content,
        isUserMessage: false,
      );

      setState(() {
        _messages.add(responseMessage);
      });
    } on GroqException catch (error) {
      ErrorMessage errorMessage = ErrorMessage(
        text: error.message,
      );

      setState(() {
        _messages.add(errorMessage);
      });
    }
    _scrollToBottomWithDelay(
      const Duration(milliseconds: 300),
    );
  }
}
```

## Supported Models
The package supports various Groq AI models, including:
- qwem/qwen3-32b
- llama-3.3-70b-versatile
- openai/gpt-oss-120b
- And more (check Groq documentation for latest models)

## Key Methods
- `startChat()`: Initializes a new chat session
- `sendMessage(String message)`: Sends a message and receives a response
- `setCustomInstructionsWith(String instructions)`: Sets custom system instructions for the AI
- `clearChat()`: Clears the current chat context

## Error Handling
The package includes built-in error handling with `GroqException` to help you manage API interactions gracefully.

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## Disclaimer
This package is a community project and is not officially affiliated with Groq.
