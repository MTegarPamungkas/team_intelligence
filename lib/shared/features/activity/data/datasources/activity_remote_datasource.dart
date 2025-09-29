import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import 'package:team_intelligence/core/error/exceptions.dart';
import 'package:team_intelligence/core/network/network_client.dart';
import 'package:team_intelligence/shared/constants/api_endpoints.dart';
import 'package:team_intelligence/shared/features/activity/data/models/activity_model.dart';

abstract class ActivityRemoteDataSource {
  Future<ActivityResponseModel> getActivity(String id);
}

class ActivityRemoteDataSourceImpl implements ActivityRemoteDataSource {
  final NetworkClient networkClient;

  ActivityRemoteDataSourceImpl(this.networkClient);

  @override
  Future<ActivityResponseModel> getActivity(String id) async {
    try {
      final response = await networkClient.get(ApiEndpoints.activities(id));
      return ActivityResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      dev.log(
        'DioException: ${e.response?.data}',
        name: 'ActivityRemoteDataSourceImpl',
      );
      throw ServerException(message: e.response?.data['message'] ?? e.message);
    }
  }
}
