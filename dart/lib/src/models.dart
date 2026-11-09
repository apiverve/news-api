/// Response models for the World News API.

/// API Response wrapper.
class NewsResponse {
  final String status;
  final dynamic error;
  final NewsData? data;

  /// Set only when the current plan locks one or more fields; null otherwise.
  final PremiumInfo? premium;

  NewsResponse({
    required this.status,
    this.error,
    this.data,
    this.premium,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
    status: json['status'] as String? ?? '',
    error: json['error'],
    data: json['data'] != null ? NewsData.fromJson(json['data']) : null,
    premium: json['premium'] != null ? PremiumInfo.fromJson(json['premium']) : null,
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    if (error != null) 'error': error,
    if (data != null) 'data': data,
    if (premium != null) 'premium': premium!.toJson(),
  };
}

/// Describes fields the current plan does not unlock. Locked fields arrive as null
/// in [data], and [lockedFields] names them (nested ones use dot paths).
class PremiumInfo {
  final String? message;
  final String? upgradeUrl;
  final List<String>? lockedFields;

  PremiumInfo({this.message, this.upgradeUrl, this.lockedFields});

  factory PremiumInfo.fromJson(Map<String, dynamic> json) => PremiumInfo(
    message: json['message'] as String?,
    upgradeUrl: json['upgrade_url'] as String?,
    lockedFields: (json['locked_fields'] as List?)?.map((e) => e.toString()).toList(),
  );

  Map<String, dynamic> toJson() => {
    if (message != null) 'message': message,
    if (upgradeUrl != null) 'upgrade_url': upgradeUrl,
    if (lockedFields != null) 'locked_fields': lockedFields,
  };
}

/// Response data for the World News API.

class NewsData {
  String? date;
  String? category;
  dynamic edition;
  List<String>? languages;
  dynamic country;
  String? sort;
  String? lastUpdated;
  num? articleCount;
  List<NewsDataArticlesItem>? articles;

  NewsData({
    this.date,
    this.category,
    this.edition,
    this.languages,
    this.country,
    this.sort,
    this.lastUpdated,
    this.articleCount,
    this.articles,
  });

  factory NewsData.fromJson(Map<String, dynamic> json) => NewsData(
      date: json['date'],
      category: json['category'],
      edition: json['edition'],
      languages: (json['languages'] as List?)?.cast<String>(),
      country: json['country'],
      sort: json['sort'],
      lastUpdated: json['lastUpdated'],
      articleCount: json['articleCount'],
      articles: (json['articles'] as List?)?.map((e) => NewsDataArticlesItem.fromJson(e)).toList(),
    );
}

class NewsDataArticlesItem {
  String? category;
  String? website;
  String? title;
  String? pubDate;
  String? image;
  String? description;
  String? link;
  String? id;
  List<String>? categories;
  List<dynamic>? countries;
  String? edition;
  String? language;
  num? coverage;
  List<NewsDataArticlesItemSourcesItem>? sources;
  String? sentiment;
  num? sentimentScore;

  NewsDataArticlesItem({
    this.category,
    this.website,
    this.title,
    this.pubDate,
    this.image,
    this.description,
    this.link,
    this.id,
    this.categories,
    this.countries,
    this.edition,
    this.language,
    this.coverage,
    this.sources,
    this.sentiment,
    this.sentimentScore,
  });

  factory NewsDataArticlesItem.fromJson(Map<String, dynamic> json) => NewsDataArticlesItem(
      category: json['category'],
      website: json['website'],
      title: json['title'],
      pubDate: json['pubDate'],
      image: json['image'],
      description: json['description'],
      link: json['link'],
      id: json['id'],
      categories: (json['categories'] as List?)?.cast<String>(),
      countries: (json['countries'] as List?)?.cast<dynamic>(),
      edition: json['edition'],
      language: json['language'],
      coverage: json['coverage'],
      sources: (json['sources'] as List?)?.map((e) => NewsDataArticlesItemSourcesItem.fromJson(e)).toList(),
      sentiment: json['sentiment'],
      sentimentScore: json['sentimentScore'],
    );
}

class NewsDataArticlesItemSourcesItem {
  String? website;
  String? title;
  String? link;
  String? pubDate;

  NewsDataArticlesItemSourcesItem({
    this.website,
    this.title,
    this.link,
    this.pubDate,
  });

  factory NewsDataArticlesItemSourcesItem.fromJson(Map<String, dynamic> json) => NewsDataArticlesItemSourcesItem(
      website: json['website'],
      title: json['title'],
      link: json['link'],
      pubDate: json['pubDate'],
    );
}

class NewsRequest {
  String? category;
  String? country;
  String? edition;
  String? language;
  String? sort;
  String? q;
  String? since;
  int? limit;

  NewsRequest({
    this.category,
    this.country,
    this.edition,
    this.language,
    this.sort,
    this.q,
    this.since,
    this.limit,
  });

  Map<String, dynamic> toJson() => {
      if (category != null) 'category': category,
      if (country != null) 'country': country,
      if (edition != null) 'edition': edition,
      if (language != null) 'language': language,
      if (sort != null) 'sort': sort,
      if (q != null) 'q': q,
      if (since != null) 'since': since,
      if (limit != null) 'limit': limit,
    };
}
