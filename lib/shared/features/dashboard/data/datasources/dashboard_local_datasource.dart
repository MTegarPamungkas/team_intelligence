import 'dart:convert';
import 'package:team_intelligence/core/error/exceptions.dart';
import 'package:team_intelligence/core/storage/local_storage.dart';
import 'package:team_intelligence/shared/features/dashboard/data/models/summary_response_model.dart';

abstract class DashboardLocalDataSource {
  Future<SummaryResponseModel> getDashboard();
  Future<void> cacheDashboard(SummaryResponseModel model);
}

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final LocalStorage localStorage;

  DashboardLocalDataSourceImpl(this.localStorage);

  @override
  Future<SummaryResponseModel> getDashboard() async {
    final jsonString = localStorage.getString('dashboard');
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return SummaryResponseModel.fromJson(jsonMap);
    }
    throw CacheException();
  }

  @override
  Future<void> cacheDashboard(SummaryResponseModel model) async {
    final jsonString = json.encode(model.toJson());
    await localStorage.setString('dashboard', jsonString);
  }
}
