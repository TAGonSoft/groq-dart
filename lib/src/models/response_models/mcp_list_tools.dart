/// List of discovered MCP tools from connected servers.
class McpListTools {
  /// The type of this output, always "mcp_list_tools".
  final String type;

  /// The label identifying which MCP server provided these tools.
  final String serverLabel;

  /// The list of tools available from the MCP server.
  final List<McpTool> tools;

  McpListTools({
    required this.type,
    required this.serverLabel,
    required this.tools,
  });

  factory McpListTools.fromJson(Map<String, dynamic> json) {
    return McpListTools(
      type: json['type'] as String,
      serverLabel: json['server_label'] as String,
      tools: List<McpTool>.from(
        (json['tools'] as List<dynamic>).map(
          (tool) => McpTool.fromJson(tool as Map<String, dynamic>),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'server_label': serverLabel,
        'tools': tools.map((tool) => tool.toJson()).toList(),
      };
}

/// A tool provided by an MCP server.
class McpTool {
  /// The tool's identifier.
  final String name;

  /// A description explaining the tool's purpose and capabilities.
  final String? description;

  /// The JSON Schema defining the tool's input parameters.
  final Map<String, dynamic>? inputSchema;

  McpTool({
    required this.name,
    this.description,
    this.inputSchema,
  });

  factory McpTool.fromJson(Map<String, dynamic> json) {
    return McpTool(
      name: json['name'] as String,
      description: json['description'] as String?,
      inputSchema: json['input_schema'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{'name': name};
    if (description != null) {
      map['description'] = description;
    }
    if (inputSchema != null) {
      map['input_schema'] = inputSchema;
    }
    return map;
  }
}
