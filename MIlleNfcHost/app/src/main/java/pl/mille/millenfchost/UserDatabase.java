package pl.mille.millenfchost;

class User {
  String userIdentifier; // total user identifier;
  byte userToken; // current user token on the device

  public User(String identifier, byte token) {
    this.userIdentifier = identifier;
    this.userToken = token;
  }
}

class UserDatabase {

  private User[] users = {
    new User("62C5862B-AC75-4179-882A-D319F9D37B51", (byte)1),
      new User("F94EF1A6-7994-4A71-B78B-218C939DF24B", (byte)2),

  };

  public User getUser(String userIdentifier) {

    for (int i = 0; i < users.length; i++ ) {
      User user = users[i];
      if (user.userIdentifier.equalsIgnoreCase(userIdentifier)) {
        return user;
      }
    }

    return null;
  }
}
