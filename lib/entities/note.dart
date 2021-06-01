class Note {
  int? id;
  String? description = "";
  String? date = "";
  Note(
      {this.description, this.date});

  Note.parameters(
      String description, String date) {
    this.description = description;
    this.date = date;
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'description': description,
      'date': date,
    };
  }

  Note.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.description = map['description'];
    this.date = map['date'];
  }

}
