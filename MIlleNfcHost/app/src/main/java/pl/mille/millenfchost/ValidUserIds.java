package pl.mille.millenfchost;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class User {
  String userIdentifier; // total user identifier;
  byte userToken; // current user token on the device

  public User(String identifier, byte token) {
    this.userIdentifier = identifier;
    this.userToken = token;
  }
}

class ValidUserIds {

  private Set<String> usersIds = new HashSet(Arrays.asList(
      "62C5862B-AC75-4179-882A-D319F9D37B51",
      "F94EF1A6-7994-4A71-B78B-218C939DF24B"
  ));

  public Boolean canLogIn(String userIdentifier) {
    return usersIds.contains(userIdentifier);
  }
}
