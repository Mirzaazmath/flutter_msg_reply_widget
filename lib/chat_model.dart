class ChatModel {
  final bool isSender;
  final String msg;
  final String name;
  final int id;
  final String time;
  final bool? isRely;
  final String? parentMsg;

  ChatModel(
      {required this.isSender,
      required this.msg,
      required this.name,
      required this.id,
      required this.time,
        this.isRely,
        this.parentMsg
      });
}

