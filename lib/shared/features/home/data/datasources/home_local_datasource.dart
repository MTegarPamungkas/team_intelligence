import 'dart:convert';
import 'package:team_intelligence/core/error/exceptions.dart';
import 'package:team_intelligence/core/storage/local_storage.dart';
import 'package:team_intelligence/shared/features/home/data/models/home_model.dart';
import 'package:team_intelligence/shared/features/home/data/models/my_projects_model.dart';

abstract class HomeLocalDataSource {
  Future<HomeModel> getHome();
  Future<MyProjectsModel> getMyProjects();
  Future<void> cacheHome(HomeModel model);
  Future<void> cacheMyProjects(MyProjectsModel model);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final LocalStorage localStorage;

  HomeLocalDataSourceImpl(this.localStorage);

  @override
  Future<HomeModel> getHome() async {
    final jsonString = localStorage.getString('home');
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return HomeModel.fromJson(jsonMap);
    }
    throw CacheException();
  }

  @override
  Future<MyProjectsModel> getMyProjects() async {
    final jsonString = localStorage.getString('home');
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return MyProjectsModel.fromJson(jsonMap);
    }
    throw CacheException();
  }

  @override
  Future<void> cacheHome(HomeModel model) async {
    final jsonString = json.encode(model.toJson());
    await localStorage.setString('home', jsonString);
  }

  @override
  Future<void> cacheMyProjects(MyProjectsModel model) async {
    final jsonString = json.encode(model.toJson());
    await localStorage.setString('my-projects', jsonString);
  }
}
