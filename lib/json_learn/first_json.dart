class FirstJson {
  final int id;
  final String name;

  FirstJson(this.id, this.name);

  Map toJson() {
    return {"id": id, "name": name};
  }
}
