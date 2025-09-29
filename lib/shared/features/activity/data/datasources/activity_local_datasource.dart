import 'dart:convert';
import 'package:team_intelligence/core/error/exceptions.dart';
import 'package:team_intelligence/core/storage/local_storage.dart';
import 'package:team_intelligence/shared/features/activity/data/models/activity_model.dart';

abstract class ActivityLocalDataSource {
  Future<ActivityResponseModel> getActivity();
  Future<void> cacheActivity(ActivityResponseModel model);
}

class ActivityLocalDataSourceImpl implements ActivityLocalDataSource {
  final LocalStorage localStorage;

  ActivityLocalDataSourceImpl(this.localStorage);

  @override
  Future<ActivityResponseModel> getActivity() async {
    final jsonString = localStorage.getString('activity');
    if (jsonString != null) {
      // Convert String to Map<String, dynamic>
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return ActivityResponseModel.fromJson(jsonMap);
    }
    throw CacheException();
  }

  @override
  Future<void> cacheActivity(ActivityResponseModel model) async {
    // Convert Map<String, dynamic> to String
    final jsonString = json.encode(model.toJson());
    await localStorage.setString('activity', jsonString);
  }
}
