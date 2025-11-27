/// A tool the model may call. Currently, only functions are supported.
class Tool {
  const Tool.function({
    required this.name,
    required this.description,
    required this.parameters,
  });

  /// The name of the function to be called.
  final String name;

  /// A description of what the function does, used by the model to choose
  /// when and how to call the function.
  final String description;

  /// The parameters the function accepts, described as a JSON Schema object.
  final Map<String, dynamic> parameters;

  Map<String, dynamic> toNonNullMap() => {
        'type': 'function',
        'function': {
          'name': name,
          'description': description,
          'parameters': parameters,
        },
      };
}
