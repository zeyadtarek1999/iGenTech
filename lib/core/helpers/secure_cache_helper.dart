import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../injection_container.dart';
import 'dart:convert';

class SecureCacheHelper {
  final _secureStorage = const FlutterSecureStorage();
  final SharedPreferences _sharedPreferences = getIt<SharedPreferences>();

  // Save encrypted user data (list of users)
  Future<void> saveEncryptedUserList(List<Map<String, dynamic>> users, {required String key}) async {
    try {
      // Convert the list of users to JSON string and encode it
      String jsonUsers = jsonEncode(users);
      String encryptedData = base64Encode(utf8.encode(jsonUsers));

      // Save the encrypted data in secure storage
      await _secureStorage.write(key: key, value: encryptedData);
    } catch (e) {
      debugPrint('Error saving encrypted user list: $e');
    }
  }

  // Get decrypted user data (list of users)
  Future<List<Map<String, dynamic>>?> getDecryptedUserList({required String key}) async {
    try {
      String? encryptedData = await _secureStorage.read(key: key);
      if (encryptedData != null) {
        // Decrypt the data and decode it from JSON string
        String decryptedData = utf8.decode(base64Decode(encryptedData));
        List<dynamic> decodedJson = jsonDecode(decryptedData);

        // Cast the decoded JSON to a List<Map<String, dynamic>>
        return decodedJson.map((user) => Map<String, dynamic>.from(user)).toList();
      }
    } catch (e) {
      debugPrint('Error retrieving encrypted user list: $e');
    }
    return null;
  }
  Future<void> saveSecureData({required String key, required String value}) async {
    try {
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      debugPrint('Error saving secure data: $e');
    }
  }

  Future<String?> getSecureData({required String key}) async {
    try {
      return await _secureStorage.read(key: key);
    } catch (e) {
      print('Error reading secure data: $e');
      return null;
    }
  }

  Future<void> removeSecureData({required String key}) async {
    try {
      await _secureStorage.delete(key: key);
    } catch (e) {
      debugPrint('Error removing secure data: $e');
    }
  }

  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is String) {
      return _sharedPreferences.setString(key, value);
    } else if (value is int) {
      return _sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      return _sharedPreferences.setBool(key, value);
    } else if (value is double) {
      return _sharedPreferences.setDouble(key, value);
    } else if (value is List<String>) {
      return _sharedPreferences.setStringList(key, value);
    }
    return false;
  }

  dynamic getData({required String key}) {
    return _sharedPreferences.get(key);
  }

  Future<bool> removeData({required String key}) async {
    return _sharedPreferences.remove(key);
  }

  Future<void> saveEncryptedData({required String key, required String value}) async {
    try {
      String encodedData = base64Encode(utf8.encode(value));
      await _secureStorage.write(key: key, value: encodedData);
    } catch (e) {
      debugPrint('Error saving encrypted data: $e');
    }
  }

  Future<String?> getDecryptedData({required String key}) async {
    try {
      String? encryptedData = await _secureStorage.read(key: key);
      if (encryptedData != null) {
        return utf8.decode(base64Decode(encryptedData));
      }
      return null;
    } catch (e) {
      debugPrint('Error retrieving encrypted data: $e');
      return null;
    }
  }
}
