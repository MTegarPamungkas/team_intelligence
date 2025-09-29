abstract class BaseModel {
  Map<String, dynamic> toJson();

  static List<T> fromJsonList<T>(
    List<dynamic> jsonList,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return jsonList
        .map((json) => fromJson(json as Map<String, dynamic>))
        .toList();
  }

  static T fromJsonSingle<T>(
    dynamic json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return fromJson(json as Map<String, dynamic>);
  }
}
