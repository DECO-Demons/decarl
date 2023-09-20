class Art {
    final String? id;
    final String user_id;
    final Timestamp time_created; // Figure out type for this
    final Latlon lat_lon; // Also for this
    final Blob image_blob; // And this
    // final int likes_count; // May not implement
    // final List<String>? like_ids; // May not implement
    // final List<String>? comment_ids; // May not implement

    Art({
        this.id,
        required this.user_id,
        required this.time_created,
        required this.lat_lon,
        required this.image_blob
    });

    Map<String, dynamic> toMap() {
        return {
            "user_id": user_id,
            "time_created": time_created, // convert to string
            "lat_lon": lat_lon, // convert to string
            "image_blob": image_blob // whatever format this will be
        };
    }

    Art.fromMap(Map<String, dynamic> artData)
        : id = artData["id"], // will be root node
          user_id = artData["user_id"]
          time_created = artData["time_created"], // Convert to whatever type
          lat_lon = artData["lat_lon"], // Also convert
          image_blob = artData["image_blob"]; // also convert
}
