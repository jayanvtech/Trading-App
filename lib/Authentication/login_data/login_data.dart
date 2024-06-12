class User {
  final String userID;
  final bool isReset2FA;
  final int authenticationType;

  User(this.userID, this.isReset2FA, this.authenticationType);

  factory User.fromJson(Map<String, dynamic> json) => User(
        json['userID'] as String,
        json['isReset2FA'] as bool,
        json['authenticationType'] as int,
      );
}