class Notes {
  List<Note>? listNotes;

  Notes({this.listNotes});

  Notes.fromJson(Map<String, dynamic> json) {
    if (json['getAllNotes'] != null) {
      listNotes = <Note>[];
      json['getAllNotes'].forEach((v) {
        listNotes!.add(Note.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listNotes != null) {
      data['getAllNotes'] = listNotes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Note {
  int? createdOn;
  String? id;
  String? note;
  bool? status;
  String? title;
  int? updatedOn;
  String? username;

  Note(
      {this.createdOn,
        this.id,
        this.note,
        this.status,
        this.title,
        this.updatedOn,
        this.username});

  Note.fromJson(Map<String, dynamic> json) {
    createdOn = json['createdOn'];
    id = json['id'];
    note = json['note'];
    status = json['status'];
    title = json['title'];
    updatedOn = json['updatedOn'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdOn'] = createdOn;
    data['id'] = id;
    data['note'] = note;
    data['status'] = status;
    data['title'] = title;
    data['updatedOn'] = updatedOn;
    data['username'] = username;
    return data;
  }
}
