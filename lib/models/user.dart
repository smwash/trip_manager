class User {
  final String userId;
  final String userName;
  final String profilePic;
  final String userEmail;

  User({
    this.userId,
    this.userName,
    this.profilePic,
    this.userEmail,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'profilePic': profilePic,
      'userName': userName,
      'userEmail': userEmail,
    };
  }

  User.fromFirestore(Map<String, dynamic> doc)
      : userId = doc['userId'],
        userName = doc['userName'],
        userEmail = doc['userEmail'],
        profilePic = doc['profilePic'];
}
