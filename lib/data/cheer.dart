class Cheer {
  String senderEmail;
  String senderName;
  String senderImgData;
  String receiverName;
  String senderRole;
  String receiverEmail;
  String cheerMsg;
  String title;
  int color;
  int label;
  String category;
  DateTime createdAt;
  String companyName;

  Cheer();

  Cheer.name(
    this.title,
    this.senderEmail,
    this.senderName,
    this.senderImgData,
    this.receiverName,
    this.senderRole,
    this.receiverEmail,
    this.cheerMsg,
    this.color,
    this.label,
    this.category,
    this.createdAt,
    this.companyName,
  );

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'senderEmail': this.senderEmail,
      'senderImgData': this.senderImgData,
      'senderRole': this.senderRole,
      'receiverEmail': this.receiverEmail,
      'senderName': this.senderName,
      'receiverName': this.receiverName,
      'cheerMsg': this.cheerMsg,
      'color': this.color,
      'label': this.label,
      'category': this.category,
      'createdAt': this.createdAt,
      'companyName':this.companyName,
    };
  }

  Cheer.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        senderImgData = json['senderImgData'],
        senderName = json['senderName'],
        senderEmail = json['senderEmail'],
        receiverEmail = json['receiverEmail'],
        receiverName = json['receiverName'],
        senderRole = json['senderRole'],
        cheerMsg = json['cheerMsg'],
        color = json['color'],
        label = json['label'],
        category = json['category'],
        createdAt = json['createdAt'].toDate(),
        companyName = json['companyName'];

  static createdAtToDifference(createdAt) {
    DateTime dateTimeNow = DateTime.now();
    var timeAgo = '';
    var day = dateTimeNow.difference(createdAt).inDays;
    if (day < 1) {
      var hrs = dateTimeNow.difference(createdAt).inHours;
      if (hrs < 1) {
        var min = dateTimeNow.difference(createdAt).inMinutes;
        timeAgo = min.toString() + 'min';
      } else {
        timeAgo = hrs.toString() + 'hrs';
      }
    } else {
      timeAgo = day.toString() + 'days';
    }
    return timeAgo;
  }
}
