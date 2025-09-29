import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import 'package:team_intelligence/core/error/exceptions.dart';
import 'package:team_intelligence/core/network/network_client.dart';
import 'package:team_intelligence/shared/constants/api_endpoints.dart';
import 'package:team_intelligence/shared/features/insight/data/models/insight_model.dart';

abstract class InsightRemoteDataSource {
  Future<InsightResponseModel> getInsight(String id);
}

class InsightRemoteDataSourceImpl implements InsightRemoteDataSource {
  final NetworkClient networkClient;

  InsightRemoteDataSourceImpl(this.networkClient);

  @override
  Future<InsightResponseModel> getInsight(String id) async {
    try {
      final response = await networkClient.get(ApiEndpoints.insights(id));
      return InsightResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      dev.log(
        'DioException: ${e.response?.data}',
        name: 'InsightRemoteDataSourceImpl',
      );
      throw ServerException(message: e.response?.data['message'] ?? e.message);
    }
  }
}
