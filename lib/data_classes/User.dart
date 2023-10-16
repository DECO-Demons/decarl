class User {
    final String? id;
    final String display_name;
    final String full_name;
    final String location;
    final List<String>? follows_user_ids;
    // final List<ArtistUnlock> artist_unlocks; // May not implement

    User({
         this.id,
         required this.display_name,
         required this.full_name,
         required this.location,
         this.follows_user_ids
    })

    // Function to convert class -> db uploadable data
    Map<String, dynamic> toMap() {
        return {
            "display_name": display_name,
            "full_name": full_name,
            "location": location,
            "follows_user_ids": follows_user_ids!.join(",")
        };
    }

    // https://petercoding.com/firebase/2022/02/16/how-to-model-your-firebase-data-class-in-flutter/
    User.fromMap(Map<String, dynamic> userData)
        : id = userData["id"], // This will be root of the object? not sure how to access
          display_name = userData["display_name"],
          full_name = userData["full_name"],
          location = userData["location"],
          follows_user_ids = userData["follows_user_ids"].split(",");
}
