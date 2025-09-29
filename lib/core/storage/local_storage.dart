import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_intelligence/shared/models/project_model.dart';
import 'package:team_intelligence/shared/models/user_model.dart';

class LocalStorage {
  final SharedPreferences _prefs;

  LocalStorage(this._prefs);

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  Future<void> saveUser(UserModel? user) async {
    final model = user;
    final jsonString = jsonEncode(model?.toJson());
    await setString('user', jsonString);
  }

  String? getString(String key) => _prefs.getString(key);

  UserModel? getUser() {
    final jsonString = getString('user');
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return UserModel.fromJson(jsonMap);
    }
    return null;
  }

  Future<void> removeUSer() async {
    await _prefs.remove("user");
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }

  // Project Selection
  static const String _selectedProjectKey = 'selected_project';
  final StreamController<String?> _projectChangeController =
      StreamController<String?>.broadcast();
  Stream<String?> get selectedProjectStream => _projectChangeController.stream;
  ProjectModel? _selectedProject;

  Future<void> setSelectedProject(ProjectModel project) async {
    _selectedProject = project;
    final jsonString = jsonEncode(project.toJson());
    await setString(_selectedProjectKey, jsonString);
    _projectChangeController.add(project.id);
  }

  ProjectModel? getSelectedProject() {
    if (_selectedProject != null) {
      return _selectedProject;
    }

    final jsonString = getString(_selectedProjectKey);
    if (jsonString != null) {
      try {
        final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        _selectedProject = ProjectModel.fromJson(jsonMap);
        return _selectedProject;
      } catch (e) {
        remove(_selectedProjectKey);
        return null;
      }
    }

    return null;
  }

  void initSelectedProject() {
    final savedProject = getSelectedProject();
    if (savedProject != null) {
      _projectChangeController.add(savedProject.id);
    }
  }

  Future<void> clearSelectedProject() async {
    _selectedProject = null;
    await remove(_selectedProjectKey);
    _projectChangeController.add(null);
  }

  void dispose() {
    _projectChangeController.close();
  }
}
