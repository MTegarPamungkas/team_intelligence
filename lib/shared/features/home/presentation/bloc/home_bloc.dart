import 'dart:developer' as dev;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:team_intelligence/core/services/navigation_service.dart';
import 'package:team_intelligence/core/storage/local_storage.dart';
import 'package:team_intelligence/shared/features/home/domain/usecases/home.dart';
import 'package:team_intelligence/shared/features/home/presentation/bloc/home_event.dart';
import 'package:team_intelligence/shared/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Home home;
  final LocalStorage localStorage = GetIt.instance<LocalStorage>();
  final navigationService = GetIt.instance.get<NavigationService>();

  HomeBloc(this.home) : super(HomeInitial()) {
    on<FetchHome>(_onFetchHome);
    on<FetchMyProjectsHomeEvent>(_onFetchMyProjects);
  }

  Future<void> _onFetchHome(FetchHome event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final result = await home();
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (entity) => emit(HomeLoaded(entity)),
    );
  }

  Future<void> _onFetchMyProjects(
    FetchMyProjectsHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final result = await home.getMyProjects();
    result.fold(
      (failure) {
        dev.log('Error fetching projects: ${failure.message}');
        emit(HomeError(failure.message));
      },
      (projects) {
        dev.log('Projects fetched successfully: $projects', name: 'HomeBloc');
        emit(HomeProjectsLoaded(projects));
      },
    );
  }
}
