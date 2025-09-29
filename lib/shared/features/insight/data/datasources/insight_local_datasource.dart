import 'dart:convert';
import 'package:team_intelligence/core/error/exceptions.dart';
import 'package:team_intelligence/core/storage/local_storage.dart';
import 'package:team_intelligence/shared/features/insight/data/models/insight_model.dart';

abstract class InsightLocalDataSource {
  Future<InsightResponseModel> getInsight();
  Future<void> cacheInsight(InsightResponseModel model);
}

class InsightLocalDataSourceImpl implements InsightLocalDataSource {
  final LocalStorage localStorage;

  InsightLocalDataSourceImpl(this.localStorage);

  @override
  Future<InsightResponseModel> getInsight() async {
    final jsonString = localStorage.getString('insight');
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return InsightResponseModel.fromJson(jsonMap);
    }
    throw CacheException();
  }

  @override
  Future<void> cacheInsight(InsightResponseModel model) async {
    final jsonString = json.encode(model.toJson());
    await localStorage.setString('insight', jsonString);
  }
}
