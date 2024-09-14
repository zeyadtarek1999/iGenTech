import 'package:iGenTech/core/app_constants/local_cache_keys.dart';
import 'package:iGenTech/core/helpers/secure_cache_helper.dart';
import 'package:iGenTech/features/sign_in/domain/entities/sign_in_entity.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

abstract class SignInLocalDataSource {
  Future<bool> authenticateUser(SignInEntity signInEntity);
}

class SignInLocalDataSourceImpl implements SignInLocalDataSource {
  final SecureCacheHelper secureCacheHelper;

  SignInLocalDataSourceImpl(this.secureCacheHelper);

  @override
  Future<bool> authenticateUser(SignInEntity signInEntity) async {
    try {
      final usersData = await secureCacheHelper.getSecureData(key: AppLocalCacheKey.usersList);

      if (usersData != null) {
        final decodedData = utf8.decode(base64Decode(usersData));

        List<dynamic> usersList = jsonDecode(decodedData);

        for (var user in usersList) {
          if (user['email'] == signInEntity.email && user['password'] == signInEntity.password) {
            debugPrint('User authenticated successfully.');
            return true;
          }
        }

        debugPrint('Authentication failed. Invalid email or password.');
      } else {
        debugPrint('No user data found.');
      }
    } catch (e) {
      debugPrint('Error during user authentication: $e');
    }
    return false;
  }
}
