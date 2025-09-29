import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:team_intelligence/core/storage/local_storage.dart';
import 'package:team_intelligence/shared/features/insight/domain/usecases/insight.dart';
import 'package:team_intelligence/shared/features/insight/presentation/bloc/insight_event.dart';
import 'package:team_intelligence/shared/features/insight/presentation/bloc/insight_state.dart';

class InsightBloc extends Bloc<InsightEvent, InsightState> {
  final Insight insight;
  final LocalStorage localStorage = GetIt.instance<LocalStorage>();

  StreamSubscription<String?>? _projectChangeSubscription;
  String? _currentProjectId;

  InsightBloc(this.insight) : super(InsightInitial()) {
    on<FetchInsight>(_onFetchInsight);
    on<ProjectChanged>(_onProjectChanged);
    listenToProjectChanges();
  }

  void listenToProjectChanges() {
    _currentProjectId = localStorage.getSelectedProject()?.id;

    _projectChangeSubscription = localStorage.selectedProjectStream
        .handleError((error) {
          dev.log('Project stream error: $error', name: 'InsightBloc');
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
              name: 'InsightBloc',
            );
          },
          onDone: () {
            dev.log('Project stream closed', name: 'InsightBloc');
          },
        );
  }

  Future<void> _onFetchInsight(
    FetchInsight event,
    Emitter<InsightState> emit,
  ) async {
    emit(InsightLoading());
    final selectedProject = localStorage.getSelectedProject()?.id ?? '';

    if (selectedProject.isEmpty) {
      emit(InsightError('No project selected'));
      return;
    }
    final result = await insight(selectedProject);
    result.fold(
      (failure) {
        dev.log(
          '❌ Insight load failed after project change: ${failure.message}',
          name: 'InsightBloc',
        );
        emit(InsightError(failure.message));
      },
      (entity) {
        dev.log(
          '✅ Insight loaded successfully after project change',
          name: 'InsightBloc',
        );
        emit(InsightLoaded(entity));
      },
    );
  }

  Future<void> _onProjectChanged(
    ProjectChanged event,
    Emitter<InsightState> emit,
  ) async {
    dev.log('🔄 Project changed to: ${event.projectId}', name: 'InsightBloc');

    emit(InsightLoading());

    final result = await insight.call(event.projectId);
    result.fold(
      (failure) {
        emit(InsightError(failure.message));
        dev.log(
          '❌ Insight load failed after project change: ${failure.message}',
          name: 'InsightBloc',
        );
      },
      (entity) {
        emit(InsightLoaded(entity));
        dev.log(
          '✅ Insight loaded successfully after project change',
          name: 'InsightBloc',
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
