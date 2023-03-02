class DomainModel {
  int? id;
  String? name;

  DomainModel({
    this.id,
    this.name,
  });

  factory DomainModel.fromMap(Map<String, dynamic> map) {
    return DomainModel(
      id: map['id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}
