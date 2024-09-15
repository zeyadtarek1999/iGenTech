part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfile profile;
  ProfileLoaded(this.profile);
}

class ProfileSaved extends ProfileState {}

class ProfileDeleted extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
