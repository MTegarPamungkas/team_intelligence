import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:team_intelligence/core/storage/local_storage.dart';
import 'package:team_intelligence/shared/features/activity/domain/usecases/activity.dart';
import 'package:team_intelligence/shared/features/activity/presentation/bloc/activity_event.dart';
import 'package:team_intelligence/shared/features/activity/presentation/bloc/activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final Activity activity;
  final LocalStorage localStorage = GetIt.instance<LocalStorage>();

  StreamSubscription<String?>? _projectChangeSubscription;
  String? _currentProjectId;

  ActivityBloc(this.activity) : super(ActivityInitial()) {
    on<FetchActivity>(_onFetchActivity);
    on<ProjectChanged>(_onProjectChanged);

    _listenToProjectChanges();
  }

  void _listenToProjectChanges() {
    _currentProjectId = localStorage.getSelectedProject()?.id;

    _projectChangeSubscription = localStorage.selectedProjectStream
        .handleError((error) {
          dev.log('Project stream error: $error', name: 'ActivityBloc');
        })
        .listen(
          (projectId) {
            if (_currentProjectId != projectId && projectId != null) {
              _currentProjectId = projectId;
              add(ProjectChanged(projectId));
            }
          },
          onError: (error) {
            dev.log(
              'Project stream listener error: $error',
              name: 'DashboardBloc',
            );
          },
          onDone: () {
            dev.log('Project stream closed', name: 'DashboardBloc');
          },
        );
  }

  Future<void> _onFetchActivity(
    FetchActivity event,
    Emitter<ActivityState> emit,
  ) async {
    emit(ActivityLoading());
    final selectedProject = localStorage.getSelectedProject()?.id ?? '';
    if (selectedProject.isEmpty) {
      emit(ActivityError('No project selected'));
      return;
    }
    final result = await activity(selectedProject);
    result.fold((failure) => emit(ActivityError(failure.message)), (entity) {
      emit(ActivityLoaded(entity));
      dev.log('Activity loaded: $entity', name: 'ActivityBloc');
    });
  }

  Future<void> _onProjectChanged(
    ProjectChanged event,
    Emitter<ActivityState> emit,
  ) async {
    dev.log('🔄 Project changed to: ${event.projectId}', name: 'ActivityBloc');

    emit(ActivityLoading());

    final result = await activity(event.projectId);
    result.fold(
      (failure) {
        emit(ActivityError(failure.message));
        dev.log(
          '❌ Activity load failed after project change: ${failure.message}',
          name: 'ActivityBloc',
        );
      },
      (entity) {
        emit(ActivityLoaded(entity));
        dev.log(
          '✅ Activity loaded successfully after project change',
          name: 'ActivityBloc',
        );
      },
    );
  }

  @override
  Future<void> close() {
    _projectChangeSubscription?.cancel();
    return super.close();
  }
}
