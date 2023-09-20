class DatabaseService {
    final DatabaseReference _db = FirebaseDatabase.instance.ref(); // not correct? use realtimedatabase

    DatabaseReference getUserRef(String userId) async {
        return await _db.child("users/$userId").ref();
    }

    addUser(User userData) async {
        // https://stackoverflow.com/a/67313263
        final pushRef = await _db.child("users").push(userData.toMap());
        userData.id = pushRef.key;
    }

    updateUser(String userId, User newUserData) async {
        final DatabaseReference userRef = await getUserRef(userId);
        // use ref.set({}), need to merge values somehow
    }

    addArt(Art artObject) async {
        final pushRef = await _db.child("art").push(artObject.toMap());
        artObject.id = pushRef.key;
    }

    Future<List<User>> retrieveUsers() async {
        final usersData = _db.child("users").get();
        final List<User> userObjects = ...;
        // Convert children to User & add to list
    }

    // Can put more custom queries here
}
