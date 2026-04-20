class SeriesDao {
  final int? seriesId;
  final String? url;
  final String? name;
  final String? title;
  final String? summary;
  final String? body;
  final String? kicker;
  final String? thumbURL;
  final String? heroURL;
  final String? titleURL;
  final String? teaser;
  final bool? isMass;
  final List<dynamic>? shows;
  final List<dynamic>? tags;
  final String? platformPlayerID;
  final bool? hiddenFromApps;
  final int? relatedTagID;

  SeriesDao({
    this.seriesId,
    this.url,
    this.name,
    this.title,
    this.summary,
    this.body,
    this.kicker,
    this.thumbURL,
    this.heroURL,
    this.titleURL,
    this.teaser,
    this.isMass,
    this.shows,
    this.tags,
    this.platformPlayerID,
    this.hiddenFromApps,
    this.relatedTagID,
  });

  factory SeriesDao.fromJson(Map<String, dynamic> json) {
    return SeriesDao(
      seriesId: json['seriesId'] as int?,
      url: json['url'] as String?,
      name: json['name'] as String?,
      title: json['title'] as String?,
      summary: json['summary'] as String?,
      body: json['body'] as String?,
      kicker: json['kicker'] as String?,
      thumbURL: json['thumbURL'] as String?,
      heroURL: json['heroURL'] as String?,
      titleURL: json['titleURL'] as String?,
      teaser: json['teaser'] as String?,
      isMass: json['isMass'] as bool?,
      shows: json['shows'] as List<dynamic>?,
      tags: json['tags'] as List<dynamic>?,
      platformPlayerID: json['platformPlayerID'] as String?,
      hiddenFromApps: json['hiddenFromApps'] as bool?,
      relatedTagID: json['relatedTagID'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seriesId': seriesId,
      'url': url,
      'name': name,
      'title': title,
      'summary': summary,
      'body': body,
      'kicker': kicker,
      'thumbURL': thumbURL,
      'heroURL': heroURL,
      'titleURL': titleURL,
      'teaser': teaser,
      'isMass': isMass,
      'shows': shows,
      'tags': tags,
      'platformPlayerID': platformPlayerID,
      'hiddenFromApps': hiddenFromApps,
      'relatedTagID': relatedTagID,
    };
  }
}
