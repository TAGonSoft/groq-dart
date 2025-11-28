import 'choices.dart';
import 'usage.dart';
import 'usage_breakdown.dart';
import 'mcp_list_tools.dart';
import 'x_groq.dart';

//
// The response object received from Groq API
//
class GroqResponse {
  String id;
  String object;
  int created;
  String model;
  String? serviceTier;
  List<GroqChoices> choices;
  String? systemFingerprint;
  GroqUsage usage;
  GroqUsageBreakdown? usageBreakdown;
  List<McpListTools>? mcpListTools;
  XGroq xGroq;

  GroqResponse({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
    this.systemFingerprint,
    this.serviceTier,
    this.usageBreakdown,
    this.mcpListTools,
    required this.xGroq,
  });

  factory GroqResponse.fromJson(Map<String, dynamic> json) {
    return GroqResponse(
      id: json['id'] as String,
      object: json['object'] as String,
      created: json['created'] as int,
      model: json['model'] as String,
      choices: List<GroqChoices>.from(
        (json['choices'] as List<dynamic>).map(
          (choice) => GroqChoices.fromJson(choice as Map<String, dynamic>),
        ),
      ),
      usage: GroqUsage.fromJson(json['usage'] as Map<String, dynamic>),
      systemFingerprint: json['system_fingerprint'] as String?,
      serviceTier: json['service_tier'] as String?,
      usageBreakdown: json['usage_breakdown'] != null
          ? GroqUsageBreakdown.fromJson(
              json['usage_breakdown'] as Map<String, dynamic>)
          : null,
      mcpListTools: json['mcp_list_tools'] != null
          ? List<McpListTools>.from(
              (json['mcp_list_tools'] as List<dynamic>).map(
                (item) => McpListTools.fromJson(item as Map<String, dynamic>),
              ),
            )
          : null,
      xGroq: XGroq.fromJson(json['x_groq'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'id': id,
      'object': object,
      'created': created,
      'model': model,
      'choices': choices.map((choice) => choice.toJson()).toList(),
      'usage': usage.toJson(),
    };
    if (usageBreakdown != null) {
      map['usage_breakdown'] = usageBreakdown!.toJson();
    }
    if (mcpListTools != null) {
      map['mcp_list_tools'] =
          mcpListTools!.map((item) => item.toJson()).toList();
    }
    return map;
  }
}
