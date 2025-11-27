/// Settings for web search functionality when the model uses a web search tool.
class SearchSettings {
  const SearchSettings({
    this.country,
    this.excludeDomains,
    this.includeDomains,
    this.includeImages,
  });

  final String? country;
  final List<String>? excludeDomains;
  final List<String>? includeDomains;
  final bool? includeImages;

  Map<String, dynamic> toNonNullMap() {
    final map = <String, dynamic>{};

    if (country != null) {
      map['country'] = country;
    }

    if (excludeDomains != null) {
      map['exclude_domains'] = excludeDomains;
    }

    if (includeDomains != null) {
      map['include_domains'] = includeDomains;
    }

    if (includeImages != null) {
      map['include_images'] = includeImages;
    }

    return map;
  }
}
