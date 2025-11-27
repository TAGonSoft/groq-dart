/// Groq-specific metadata for non-streaming chat completion responses.
class XGroq {
  final String id;
  final int? seed;
  final XGroqUsage? usage;

  XGroq({
    required this.id,
    this.seed,
    this.usage,
  });

  XGroq.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        seed = json['seed'] as int?,
        usage = json['usage'] != null
            ? XGroqUsage.fromJson(json['usage'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'id': id,
    };
    if (seed != null) {
      map['seed'] = seed;
    }
    if (usage != null) {
      map['usage'] = usage!.toJson();
    }
    return map;
  }
}

class XGroqUsage {
  final int dramCachedTokens;
  final int sramCachedTokens;

  XGroqUsage({
    required this.dramCachedTokens,
    required this.sramCachedTokens,
  });

  XGroqUsage.fromJson(Map<String, dynamic> json)
      : dramCachedTokens = json['dram_cached_tokens'] as int,
        sramCachedTokens = json['sram_cached_tokens'] as int;

  Map<String, dynamic> toJson() => {
        'dram_cached_tokens': dramCachedTokens,
        'sram_cached_tokens': sramCachedTokens,
      };
}
