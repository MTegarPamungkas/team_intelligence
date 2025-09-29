import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import 'package:team_intelligence/core/error/exceptions.dart';
import 'package:team_intelligence/core/network/network_client.dart';
import 'package:team_intelligence/shared/constants/api_endpoints.dart';
import 'package:team_intelligence/shared/features/home/data/models/home_model.dart';
import 'package:team_intelligence/shared/features/home/data/models/my_projects_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeModel> getHome();
  Future<MyProjectsModel> getMyProjects();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final NetworkClient networkClient;

  HomeRemoteDataSourceImpl(this.networkClient);

  @override
  Future<HomeModel> getHome() async {
    try {
      final response = await networkClient.get(ApiEndpoints.users);
      return HomeModel.fromJson(response.data);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<MyProjectsModel> getMyProjects() async {
    try {
      final response = await networkClient.get(ApiEndpoints.myProjects);
      return MyProjectsModel.fromJson(response.data);
    } on DioException catch (e) {
      dev.log(
        'DioException: ${e.response?.data}',
        name: 'HomeRemoteDataSourceImpl',
      );
      throw ServerException(message: e.response?.data['message'] ?? e.message);
    }
  }
}
