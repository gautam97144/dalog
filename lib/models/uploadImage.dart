class UploadImage {
  String? filepathUrl;
  String? url;

  UploadImage({this.filepathUrl, this.url});

  UploadImage.fromJson(Map<String, dynamic> json) {
    filepathUrl = json['filepath_url'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filepath_url'] = this.filepathUrl;
    data['url'] = this.url;
    return data;
  }
}
