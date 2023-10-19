class Art {
    final String anchor_id;
    final String user_id;
    final int time_created;
    final String lat_lon; // Also for this
    final int likes_count; // May not implement

    Art({
        required this.anchor_id,
        required this.user_id,
        required this.time_created,
        required this.lat_lon,
        required this.likes_count
    });

    Map<String, dynamic> toMap() {
        return {
            anchor_id.toString(): {
                "user_id": user_id,
                "time_created": time_created, // convert to string
                "lat_lon": lat_lon, // convert to string
                "likes_count": this.likes_count
            }
        };
    }

    Art.fromMap(Map<String, dynamic> artData)
        : anchor_id = artData.keys.elementAt(0),
          user_id = artData["user_id"],
          time_created = artData["time_created"],
          lat_lon = artData["lat_lon"], // Also convert
          likes_count = artData["likes_count"];
}
