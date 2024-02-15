class MessageModel {
  String? senderID;
  String? receiverID;
  String? date;
  String? text;

  MessageModel({
    required this.senderID,
    required this.receiverID,
    required this.date,
    required this.text,
  });

  MessageModel.fromJson(
    Map<String?, dynamic> json,
  ) {
    senderID = json['senderID'];
    receiverID = json['receiverID'];
    date = json['date'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'receiverID': receiverID,
      'date': date,
      'text': text,
    };
  }
}
