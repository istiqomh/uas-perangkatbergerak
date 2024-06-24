class FeedbackForm {
  DateTime timestamp; 
  String email;
  String name;
  String nim;
  String link;
  String kesulitan;
  String nilai;

  FeedbackForm(this.timestamp, this.email, this.name, this.nim, this.link,
      this.kesulitan, this.nilai); 

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm(
        DateTime.parse(json['timestamp']), // Parsing timestamp dari JSON
        "${json['email']}",
        "${json['name']}",
        "${json['nim']}",
        "${json['alamat']}",
        "${json['kesulitan']}",
        "${json['nilai']}"
      );
  }

  // Method to make GET parameters.
  Map toJson() => {
        'timestamp': timestamp.toString(), // Mengonversi timestamp ke String
        'email': email,
        'name': name,
        'nim': nim,
        'link': link,
        'kesulitan': kesulitan,
        'nilai': nilai,
      };
}