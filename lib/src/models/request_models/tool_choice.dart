/// Controls which (if any) tool is called by the model.
///
/// Use one of the factory constructors to create a tool choice:
/// - [ToolChoice.none] - Model will not call any tool
/// - [ToolChoice.auto] - Model can choose between generating a message or calling tools
/// - [ToolChoice.required] - Model must call one or more tools
/// - [ToolChoice.function] - Force the model to call a specific function
sealed class ToolChoice {
  const ToolChoice();

  const factory ToolChoice.none() = NoneToolChoice;
  const factory ToolChoice.auto() = AutoToolChoice;
  const factory ToolChoice.required() = RequiredToolChoice;
  const factory ToolChoice.function({required String name}) =
      FunctionToolChoice;

  Object toNonNullMap();
}

/// Model will not call any tool.
final class NoneToolChoice extends ToolChoice {
  const NoneToolChoice();

  @override
  Object toNonNullMap() => 'none';
}

/// Model can choose between generating a message or calling tools.
final class AutoToolChoice extends ToolChoice {
  const AutoToolChoice();

  @override
  Object toNonNullMap() => 'auto';
}

/// Model must call one or more tools.
final class RequiredToolChoice extends ToolChoice {
  const RequiredToolChoice();

  @override
  Object toNonNullMap() => 'required';
}

/// Force the model to call a specific function by name.
final class FunctionToolChoice extends ToolChoice {
  final String name;

  const FunctionToolChoice({required this.name});

  @override
  Object toNonNullMap() => {
        'type': 'function',
        'function': {'name': name},
      };
}
