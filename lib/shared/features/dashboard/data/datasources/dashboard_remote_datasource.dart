import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import 'package:team_intelligence/core/error/exceptions.dart';
import 'package:team_intelligence/core/network/network_client.dart';
import 'package:team_intelligence/shared/constants/api_endpoints.dart';
import 'package:team_intelligence/shared/features/dashboard/data/models/summary_response_model.dart';

abstract class DashboardRemoteDataSource {
  Future<SummaryResponseModel> getDashboard(String Id);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final NetworkClient networkClient;

  DashboardRemoteDataSourceImpl(this.networkClient);

  @override
  Future<SummaryResponseModel> getDashboard(String id) async {
    try {
      final response = await networkClient.get(ApiEndpoints.projects(id));
      dev.log(
        'GetDashboard Response: ${response.data}',
        name: 'DashboardRemoteDataSourceImpl',
      );
      return SummaryResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      dev.log(
        'DioException: ${e.response?.data}',
        name: 'DashboardRemoteDataSourceImpl',
      );
      throw ServerException(message: e.response?.data['message'] ?? e.message);
    }
  }
}
