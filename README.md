# Groq Generative AI
The Groq AI SDK for Dart allows developers to use Large Language Models (LLMs) to build language applications.

## Getting Started

### API keys

To use the Groq API, you'll need an API key. If you don't already have one, 
create a key in GroqCloud: https://console.groq.com/playground.

### Examples

See an example app at [samples/dart](samples/dart/),
including some getting started instructions.

## Using the SDK in your own app

Add a dependency on the `package:groq` package via:

```shell
dart pub add groq
```

or:

```shell
flutter pub add groq
```

### Set the API key

```shell
flutter run --dart-define=groqApiKey='Your Api Key'
```

### Import package
```dart
import 'package:groq/groq.dart';
```

### Initializing the API client

```dart
final groq = Groq(apiKey: const String.fromEnvironment('groqApiKey'));
```

### Calling the API

#### To send a message
```dart
groq.startChat();

try {

GroqResponse response = await groq.sendMessage(text);

print(response.choices.first.message.content)

} on GroqException catch (error) {
    print(error.message)
}
```


#### To set helpful information for assistant
```dart
groq.startChat();
groq.setCustomInstructionsWith(instructions);

try {

GroqResponse response = await groq.sendMessage(text);

print(response.choices.first.message.content)

} on GroqException catch (error) {
    print(error.message)
}
```