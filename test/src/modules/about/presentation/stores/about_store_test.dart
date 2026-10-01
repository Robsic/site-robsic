import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:robsic/src/modules/about/about.dart';

class GetAboutPageDataUsecaseMock extends Mock
    implements GetAboutPageDataUsecase {}

void main() {
  late final GetAboutPageDataUsecase getAboutPageDataUsecaseMock;
  late final AboutStore sut;

  setUp(() {
    getAboutPageDataUsecaseMock = GetAboutPageDataUsecaseMock();
    sut = AboutStore(getAboutPageDataUsecaseMock);
  });
  test('Should start about store with AboutStateIdle', () async {
    expect(sut.value, isA<AboutStateIdle>());
  });
}
