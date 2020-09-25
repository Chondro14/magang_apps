import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserModel extends Equatable {
  final String userName;
  final String userPassword;
  final String userPhoneNumber;
  final String userPhotoProfile;
  final String userEmail;
  final String id;

  const UserModel(
      {@required this.id,
      @required this.userPhoneNumber,
      @required this.userEmail,
      @required this.userName,
      @required this.userPassword,
      @required this.userPhotoProfile})
      : assert(userPhoneNumber != null, id != null);
  static const empty = UserModel(
      userPhoneNumber: '',
      userEmail: null,
      userName: null,
      userPassword: null,
      userPhotoProfile: null,
      id: '');

  @override
  // TODO: implement props
  List<Object> get props => [
        id,
        userPhoneNumber,
        userPhotoProfile,
        userPassword,
        userName,
        userEmail
      ];
}
