class InputModel {
  String? path;
  String? source;
  InputModel({this.path, this.source});

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'source': source,
    };
  }

  InputModel.fromJson(Map<String, dynamic> json)
      : path = json['path'],
        source = json['source'];
}
