import 'package:equatable/equatable.dart';

class SplashEntity extends Equatable {
  final bool isLoggedIn;
  final bool isFirstTime;
  final String? userId;
  final String? userName;

  const SplashEntity({
    required this.isLoggedIn,
    required this.isFirstTime,
    this.userId,
    this.userName,
  });

  factory SplashEntity.fromLocalData({
    required bool isLoggedIn,
    required bool isFirstTime,
    String? userId,
    String? userName,
  }) {
    return SplashEntity(
      isLoggedIn: isLoggedIn,
      isFirstTime: isFirstTime,
      userId: userId,
      userName: userName,
    );
  }

  factory SplashEntity.notLoggedIn({bool isFirstTime = false}) {
    return SplashEntity(
      isLoggedIn: false,
      isFirstTime: isFirstTime,
      userId: null,
      userName: null,
    );
  }

  factory SplashEntity.loggedIn({
    required String userId,
    String? userName,
    bool isFirstTime = false,
  }) {
    return SplashEntity(
      isLoggedIn: true,
      isFirstTime: isFirstTime,
      userId: userId,
      userName: userName,
    );
  }

  @override
  List<Object?> get props => [isLoggedIn, isFirstTime, userId, userName];

  @override
  String toString() {
    return 'SplashEntity(isLoggedIn: $isLoggedIn, isFirstTime: $isFirstTime, userId: $userId, userName: $userName)';
  }
}
