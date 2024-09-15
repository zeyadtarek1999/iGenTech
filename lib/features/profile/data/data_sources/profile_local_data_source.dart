import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:iGenTech/core/app_constants/local_cache_keys.dart';
import 'package:iGenTech/features/profile/domain/entities/profile_entity.dart';
import 'package:iGenTech/core/helpers/secure_cache_helper.dart';

abstract class ProfileLocalDataSource {
  Future<Map<String, dynamic>?> getProfileDataByEmail(String email);
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final SecureCacheHelper secureCacheHelper;

  ProfileLocalDataSourceImpl(this.secureCacheHelper);

  @override
  Future<Map<String, dynamic>?> getProfileDataByEmail(String email) async {
    try {
      if (email.isEmpty) {
        throw Exception("Email is empty.");
      }

      List<Map<String, dynamic>>? userList = await secureCacheHelper.getDecryptedUserList(key: AppLocalCacheKey.usersList);

      if (userList != null) {
        for (var userMap in userList) {
          if (userMap['email'] == email) {
            return userMap;
          }
        }
        throw Exception("User with email $email not found.");
      }
    } catch (e) {
      debugPrint("Error retrieving profile by email: $e");
    }
    return null;
  }


}
