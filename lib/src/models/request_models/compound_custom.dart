/// Custom configuration of models and tools for Compound.
///
class CompoundCustom {
  const CompoundCustom({this.models, this.tools});

  final CompoundCustomModels? models;

  // Configuration options for tools available to Compound.
  final CompoundCustomTools? tools;

  Map<String, dynamic> toNonNullMap() {
    final map = <String, dynamic>{};
    if (models != null) {
      final modelsMap = models!.toNonNullMap();
      if (modelsMap.isNotEmpty) {
        map['models'] = modelsMap;
      }
    }
    if (tools != null) {
      final toolsMap = tools!.toNonNullMap();
      if (toolsMap.isNotEmpty) {
        map['tools'] = toolsMap;
      }
    }
    return map;
  }
}

class CompoundCustomModels {
  const CompoundCustomModels({this.answeringModel, this.reasoningModel});

  // Custom model to use for answering.
  final String? answeringModel;

  // Custom model to use for reasoning.
  final String? reasoningModel;

  Map<String, dynamic> toNonNullMap() {
    final map = <String, dynamic>{};
    if (answeringModel != null) {
      map['answering_model'] = answeringModel;
    }
    if (reasoningModel != null) {
      map['reasoning_model'] = reasoningModel;
    }
    return map;
  }
}

// Configuration options for tools available to Compound.
class CompoundCustomTools {
  const CompoundCustomTools({this.enabledTools, this.wolframSettings});

  // A list of tool names that are enabled for the request.
  final List<String>? enabledTools;

  // Configuration for the Wolfram tool integration.
  final WolframSettingsConfiguration? wolframSettings;

  Map<String, dynamic> toNonNullMap() {
    final map = <String, dynamic>{};
    if (enabledTools != null) {
      map['enabled_tools'] = enabledTools;
    }
    if (wolframSettings != null) {
      final wolframMap = wolframSettings!.toNonNullMap();
      if (wolframMap.isNotEmpty) {
        map['wolfram_settings'] = wolframMap;
      }
    }
    return map;
  }
}

class WolframSettingsConfiguration {
  const WolframSettingsConfiguration({this.authorization});

  // API key used to authorize requests to Wolfram services.
  final String? authorization;

  Map<String, dynamic> toNonNullMap() {
    final map = <String, dynamic>{};
    if (authorization != null) {
      map['authorization'] = authorization;
    }
    return map;
  }
}
