package pl.mille.millenfchost;

class User {
  byte userIdentifier; // total user identifier;
  byte userToken; // current user token on the device

  public User(byte identifier, byte token) {
    this.userIdentifier = identifier;
    this.userToken = token;
  }
}

class UserDatabase {

  private User[] users = {
    new User((byte)0x11, (byte)1)
  };

  public User getUser(byte userToken) {
    for (int i = 0; i < 1; i++ ) {
      User user = users[i];
      if (user.userToken == userToken) {
        return user;
      }
    }

    return null;
  }
}
