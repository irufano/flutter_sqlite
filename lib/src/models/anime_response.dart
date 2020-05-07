import 'dart:convert';

AnimeResponse animeResponseFromJson(String str) => AnimeResponse.fromMap(json.decode(str));

String animeResponseToJson(AnimeResponse data) => json.encode(data.toMap());

class AnimeResponse {
    String requestHash;
    bool requestCached;
    int requestCacheExpiry;
    List<Top> top;

    AnimeResponse({
        this.requestHash,
        this.requestCached,
        this.requestCacheExpiry,
        this.top,
    });

    factory AnimeResponse.fromMap(Map<String, dynamic> json) => AnimeResponse(
        requestHash: json["request_hash"],
        requestCached: json["request_cached"],
        requestCacheExpiry: json["request_cache_expiry"],
        top: List<Top>.from(json["top"].map((x) => Top.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "request_hash": requestHash,
        "request_cached": requestCached,
        "request_cache_expiry": requestCacheExpiry,
        "top": List<dynamic>.from(top.map((x) => x.toMap())),
    };
}

class Top {
    int malId;
    int rank;
    String title;
    String url;
    String imageUrl;
    String type;
    int episodes;
    String startDate;
    String endDate;
    int members;
    int score;

    Top({
        this.malId,
        this.rank,
        this.title,
        this.url,
        this.imageUrl,
        this.type,
        this.episodes,
        this.startDate,
        this.endDate,
        this.members,
        this.score,
    });

    factory Top.fromMap(Map<String, dynamic> json) => Top(
        malId: json["mal_id"],
        rank: json["rank"],
        title: json["title"],
        url: json["url"],
        imageUrl: json["image_url"],
        type: json["type"],
        episodes: json["episodes"] == null ? null : json["episodes"],
        startDate: json["start_date"] == null ? null : json["start_date"],
        endDate: json["end_date"] == null ? null : json["end_date"],
        members: json["members"],
        score: json["score"],
    );

    Map<String, dynamic> toMap() => {
        "mal_id": malId,
        "rank": rank,
        "title": title,
        "url": url,
        "image_url": imageUrl,
        "type": type,
        "episodes": episodes == null ? null : episodes,
        "start_date": startDate == null ? null : startDate,
        "end_date": endDate == null ? null : endDate,
        "members": members,
        "score": score,
    };
}
