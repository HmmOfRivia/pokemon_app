import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:persistent_storage/persistent_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/storage.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  const mockKey = 'key';
  const mockValue = 'value';
  final mockException = Exception('ex');

  group(
    'PersistentStorage read, write, delete, clear tests',
    () {
      late SharedPreferences sharedPreferences;
      late PersistentStorage persistentStorage;

      setUp(
        () {
          sharedPreferences = MockSharedPreferences();
          persistentStorage = PersistentStorage(
            sharedPreferences: sharedPreferences,
          );
        },
      );

      group(
        'read',
        () {
          test(
            'returns value when sP request is successful',
            () async {
              when(() => sharedPreferences.getString(any()))
                  .thenAnswer((_) => mockValue);
              final actual = await persistentStorage.read(key: mockKey);
              expect(actual, mockValue);
            },
          );

          test(
            'returns null when sP response is null',
            () async {
              when(() => sharedPreferences.getString(any()))
                  .thenAnswer((_) => null);
              final actual = await persistentStorage.read(key: mockKey);
              expect(actual, isNull);
            },
          );

          test(
            'thorws StorageException when sP.getString fails',
            () async {
              when(() => sharedPreferences.getString(any()))
                  .thenThrow(mockException);

              try {
                await persistentStorage.read(key: mockKey);
              } on StorageException catch (e) {
                expect(e.error, mockException);
                expect(e.stackTrace, isNotNull);
              }
            },
          );
        },
      );

      group(
        'write',
        () {
          test(
            'completes when sP.setString completes',
            () async {
              when(() => sharedPreferences.setString(any(), any()))
                  .thenAnswer((_) => Future.value(true));
              expect(
                persistentStorage.write(key: mockKey, value: mockValue),
                completes,
              );
            },
          );

          test(
            'throws StorageException when sP.setString fails',
            () async {
              when(() => sharedPreferences.setString(any(), any()))
                  .thenThrow(mockException);
              try {
                await persistentStorage.write(key: mockKey, value: mockValue);
              } on StorageException catch (e) {
                expect(e.error, mockException);
                expect(e.stackTrace, isNotNull);
              }
            },
          );
        },
      );

      group(
        'delete',
        () {
          test(
            'completes when sP.remove completes',
            () async {
              when(() => sharedPreferences.remove(any()))
                  .thenAnswer((_) => Future.value(true));
              expect(
                persistentStorage.delete(key: mockKey),
                completes,
              );
            },
          );

          test(
            'throws StorageException when sP.remove fails',
            () async {
              when(() => sharedPreferences.remove(any()))
                  .thenThrow(mockException);
              try {
                await persistentStorage.delete(key: mockKey);
              } on StorageException catch (e) {
                expect(e.error, mockException);
                expect(e.stackTrace, isNotNull);
              }
            },
          );
        },
      );

      group(
        'clear',
        () {
          test(
            'completes when sP.clear completes',
            () async {
              when(() => sharedPreferences.clear())
                  .thenAnswer((_) => Future.value(true));
              expect(persistentStorage.clear(), completes);
            },
          );

          test(
            'throws StorageException when sP.clear fails',
            () async {
              when(() => sharedPreferences.clear()).thenThrow(mockException);
              try {
                await persistentStorage.clear();
              } on StorageException catch (e) {
                expect(e.error, mockException);
                expect(e.stackTrace, isNotNull);
              }
            },
          );
        },
      );
    },
  );
}
