/// Settings for web search functionality when the model uses a web search tool.
class SearchSettings {
  /// Name of country to prioritize search results from
  final String? country;

  /// A list of domains to exclude from the search results.
  final List<String>? excludeDomains;

  /// A list of domains to include in the search results.
  final List<String>? includeDomains;

  /// Whether to include images in the search results.
  final bool? includeImages;

  const SearchSettings({
    this.country,
    this.excludeDomains,
    this.includeDomains,
    this.includeImages,
  });

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
