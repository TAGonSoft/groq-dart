# Groq Dart Package

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
  groq: ^latest_version
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
final groq = Groq(
  apiKey: const String.fromEnvironment('groqApiKey'),
  model: "gemma-7b-it", // Optional: specify a model
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

class _ChatScreenState extends State<ChatScreen> {
  final _groq = Groq(
    apiKey: const String.fromEnvironment('groqApiKey'),
    model: "gemma-7b-it",
  );

  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    // Set custom instructions when initializing
    _groq.setCustomInstructionsWith(
      "You are a helpful chat assistant for a Flutter app. " +
      "Respond concisely and be supportive."
    );
  }

  void _sendMessage(String text) async {
    // Add user message
    setState(() {
      _messages.add(ChatMessage(text: text, isUserMessage: true));
    });

    // Get AI response
    try {
      GroqResponse response = await _groq.sendMessage(text);
      setState(() {
        _messages.add(ChatMessage(
          text: response.choices.first.message.content, 
          isUserMessage: false
        ));
      });
    } on GroqException catch (error) {
      // Handle errors
      setState(() {
        _messages.add(ErrorMessage(text: error.message));
      });
    }
  }
}
```

## Supported Models
The package supports various Groq AI models, including:
- `gemma-7b-it`
- `llama2-70b-4096`
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
