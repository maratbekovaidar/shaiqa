class MusicModel {

  final String title;
  final String subtitle;
  final String backgroundImage;
  final String image;
  final String audioUri;
  final String spotifyUri;
  final String deezerUri;
  final String shazamUri;
  final String genres;
  final String album;
  final String label;
  final String release;
  final List<String> lyrics;
  final String lyricsAuthor;
  final String videoUri;

  MusicModel({
    required this.title,
    required this.subtitle,
    required this.backgroundImage,
    required this.image,
    required this.audioUri,
    required this.spotifyUri,
    required this.deezerUri,
    required this.shazamUri,
    required this.genres,
    required this.album,
    required this.label,
    required this.release,
    required this.lyrics,
    required this.lyricsAuthor,
    required this.videoUri});

  factory MusicModel.fromJson(json) {

    List<dynamic> lyricsJsonList = json['sections'][1]['text'];

    return MusicModel(
        title: json['title'],
        subtitle: json['subtitle'],
        backgroundImage: json['images']['background'],
        image: json['images']['coverart'],
        audioUri: json['hub']['actions'][1]['uri'],
        spotifyUri: json['providers'][0]['actions'][0]['uri'],
        deezerUri: json['providers'][1]['actions'][0]['uri'],
        shazamUri: json['uri'],
        genres: json['genres']['primary'],
        album: json['sections'][0]['metadata'][0]['text'],
        label: json['sections'][0]['metadata'][1]['text'],
        release: json['sections'][0]['metadata'][2]['text'],
        lyrics: lyricsJsonList.map((e) => e.toString()).toList(),
        lyricsAuthor: json['sections'][1]['footer'],
        videoUri: json['sections'][2]['youtubeurl']['actions']['uri']
    );
  }


}