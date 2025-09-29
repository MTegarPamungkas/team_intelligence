import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:team_intelligence/core/storage/local_storage.dart';
import 'package:team_intelligence/shared/features/dashboard/domain/usecases/dashboard.dart';
import 'package:team_intelligence/shared/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:team_intelligence/shared/features/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final Dashboard dashboard;
  final LocalStorage localStorage = GetIt.instance<LocalStorage>();

  StreamSubscription<String?>? _projectChangeSubscription;
  String? _currentProjectId;

  DashboardBloc(this.dashboard) : super(DashboardInitial()) {
    on<FetchDashboard>(_onFetchDashboard);
    on<ProjectChanged>(_onProjectChanged);

    listenToProjectChanges();
  }

  void listenToProjectChanges() {
    _currentProjectId = localStorage.getSelectedProject()?.id;

    _projectChangeSubscription = localStorage.selectedProjectStream
        .handleError((error) {
          dev.log('Project stream error: $error', name: 'DashboardBloc');
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

  Future<void> _onFetchDashboard(
    FetchDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    final selectedProject = localStorage.getSelectedProject()?.id ?? '';

    if (selectedProject.isEmpty) {
      emit(DashboardError('No project selected'));
      return;
    }

    final result = await dashboard.getProjectSummary(selectedProject);
    result.fold(
      (failure) {
        emit(DashboardError(failure.message));
        dev.log('🔄 Dashboard loaded unsuccessfully', name: 'DashboardBloc');
      },
      (entity) {
        emit(DashboardLoaded(entity));
        dev.log(
          '✅ Dashboard loaded successfully $entity',
          name: 'DashboardBloc',
        );
      },
    );
  }

  Future<void> _onProjectChanged(
    ProjectChanged event,
    Emitter<DashboardState> emit,
  ) async {
    dev.log('🔄 Project changed to: ${event.projectId}', name: 'DashboardBloc');

    emit(DashboardLoading());

    final result = await dashboard.getProjectSummary(event.projectId);
    result.fold(
      (failure) {
        emit(DashboardError(failure.message));
        dev.log(
          '❌ Dashboard load failed after project change: ${failure.message}',
          name: 'DashboardBloc',
        );
      },
      (entity) {
        emit(DashboardLoaded(entity));
        dev.log(
          '✅ Dashboard loaded successfully after project change',
          name: 'DashboardBloc',
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
