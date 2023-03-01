class FolderModel {
  int? id;
  String? name;
  String? path;

  FolderModel({
    this.id,
    this.name,
    this.path,
  });

  factory FolderModel.fromMap(Map<String, dynamic> map) {
    return FolderModel(
      id: map['id'],
      name: map['name'],
      path: map['path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "path": path,
    };
  }
}
