class StreamOptions {
  const StreamOptions({
    this.includeUsage,
  });

  final bool? includeUsage;

  Map<String, dynamic> toNonNullMap() {
    final map = <String, dynamic>{};
    if (includeUsage != null) {
      map['include_usage'] = includeUsage;
    }
    return map;
  }
}
