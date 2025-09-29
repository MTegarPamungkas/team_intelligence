import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:team_intelligence/core/network/network_client.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late NetworkClient networkClient;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    networkClient = NetworkClient(mockDio);
  });

  test('should call get on dio', () async {
    when(mockDio.get("any")).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: '/test'),
        data: {'data': 'test'},
        statusCode: 200,
      ),
    );

    final response = await networkClient.get('/test');
    expect(response.statusCode, 200);
    verify(mockDio.get('/test')).called(1);
  });
}
