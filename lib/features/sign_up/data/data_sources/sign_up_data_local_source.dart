import 'package:iGenTech/core/app_constants/local_cache_keys.dart';
import 'package:iGenTech/core/helpers/secure_cache_helper.dart';
import 'package:iGenTech/features/sign_up/domain/entities/sign_up_entity.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

abstract class SignUpLocalDataSource {
  Future<void> saveUser(User user);

  Future<User?> getUser(String email);
}

class SignUpLocalDataSourceImpl implements SignUpLocalDataSource {
  final SecureCacheHelper secureCacheHelper;

  SignUpLocalDataSourceImpl(this.secureCacheHelper);

  @override
  Future<void> saveUser(User user) async {
    try {
      final encryptedUserList = await secureCacheHelper.getDecryptedData(
          key: AppLocalCacheKey.usersList);

      List<Map<String, dynamic>> userList = encryptedUserList != null
          ? List<Map<String, dynamic>>.from(json.decode(encryptedUserList))
          : [];

      userList.add({
        'email': user.email,
        'password': user.password,
        'fullName': user.fullName,
        'gender': user.gender,
        'birthDate': user.birthDate,
      });

      await secureCacheHelper.saveEncryptedData(
        key: AppLocalCacheKey.usersList,
        value: json.encode(userList),
      );

      debugPrint('User data saved successfully: ${user.email}');
    } catch (e) {
      debugPrint('Error saving user data: $e');
    }
  }

  @override
  Future<User?> getUser(String email) async {
    try {
      final encryptedUserList = await secureCacheHelper.getDecryptedData(
          key: AppLocalCacheKey.usersList);

      if (encryptedUserList == null) {
        debugPrint('No users found');
        return null;
      }

      List<Map<String, dynamic>> userList =
          List<Map<String, dynamic>>.from(json.decode(encryptedUserList));

      final userMap = userList.firstWhere(
        (user) => user['email'] == email,
      );

      debugPrint('User found with email: $email');
      return User(
        email: userMap['email'],
        password: userMap['password'],
        fullName: userMap['fullName'],
        gender: userMap['gender'],
        birthDate: userMap['birthDate'],
        latitude: userMap['latitude'],
        longitude: userMap['longitude'],
      );
    } catch (e) {
      debugPrint('Error retrieving user data: $e');
    }

    return null;
  }
}
