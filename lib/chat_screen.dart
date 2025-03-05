import 'package:flutter/material.dart';
import 'package:msg_replay_wiget/chat_model.dart';
import 'package:msg_replay_wiget/swipe_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // List Of Chats
  List<ChatModel> chats = [
    ChatModel(
        isSender: true, msg: "Hello", name: "Mirza", id: 0, time: "12:00 PM"),
    ChatModel(
        isSender: false, msg: "Hi", name: "Anand", id: 1, time: "12:01 PM"),
    ChatModel(
        isSender: true,
        msg: "How are you ?",
        name: "Mirza",
        id: 2,
        time: "12:02 PM"),
    ChatModel(
        isSender: false,
        msg: "Fine What about you?",
        name: "Anand",
        id: 3,
        time: "12:03 PM"),
    ChatModel(
        isSender: true, msg: "Great!", name: "Mirza", id: 4, time: "12:04 PM"),
    ChatModel(
        isSender: false,
        msg: "Any Updates",
        name: "Anand",
        id: 5,
        time: "12:05 PM"),
    ChatModel(
        isSender: true,
        msg:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        name: "Mirza",
        id: 6,
        time: "12:07 PM"),
    ChatModel(
        isSender: false, msg: "Oh!", name: "Anand", id: 7, time: "12:08 PM"),
    ChatModel(
        isSender: true,
        msg: "Yes I know its Long ",
        name: "Mirza",
        id: 8,
        time: "12:09 PM"),
    ChatModel(
        isSender: false,
        msg: "No Problem, I will do the rest don't worries",
        name: "Anand",
        id: 9,
        time: "12:10 PM"),
    ChatModel(
        isSender: true,
        msg: "Thanks Bye",
        name: "Mirza",
        id: 10,
        time: "12:12 PM"),
    ChatModel(
        isSender: false, msg: "Bye", name: "Anand", id: 11, time: "12:15 PM"),
  ];
  // Created a variable to handle rely msg
  ChatModel? selectedChat;
  // Created  FocusNode for Keyboard
  FocusNode focusNode = FocusNode();
  // Created  TextEditingController for text
  TextEditingController _controller = TextEditingController();

  // Disposing all Controllers
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/bg.jpg",
              ),
              fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          leadingWidth: 30,
          leading: const Icon(Icons.arrow_back),
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blueGrey.shade100,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Expanded(child: Text("Anand Inapayments")),
            ],
          ),
          actions: const [
            Icon(
              Icons.videocam_outlined,
              color: Colors.black,
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.phone_outlined,
              color: Colors.black,
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    shrinkWrap: true,
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      return SwipeWidget(
                        onSwipeLeft: () {
                          focusNode.requestFocus();
                          setState(() {
                            selectedChat = chats[index];
                          });
                          print("Hello");
                        },
                        child: Row(
                          mainAxisAlignment: chats[index].isSender
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.sizeOf(context).width * 0.8,
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        chats[index].isSender ? 30 : 0),
                                    topRight: Radius.circular(
                                        chats[index].isSender ? 0 : 30),
                                    bottomLeft: const Radius.circular(30),
                                    bottomRight: const Radius.circular(30)),
                                color: chats[index].isSender
                                    ? Colors.greenAccent.shade100
                                    : Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  chats[index].isRely == true
                                      ?  _buildReplyWidget(chats[index].parentMsg ?? "",)
                                      : const SizedBox(),
                                  Text(chats[index].msg),
                                  Text(
                                    chats[index].time,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
            SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white),
                      child: Column(
                        children: [
                          selectedChat != null
                              ? Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    _buildReplyWidget(selectedChat!.msg,),
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          setState(() {
                                            selectedChat = null;
                                            focusNode.unfocus();
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          size: 20,
                                        )),
                                  ],
                                )
                              : const SizedBox(),
                          Row(
                            children: [
                              const Icon(Icons.account_balance_wallet_outlined),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: TextFormField(
                                controller: _controller,
                                focusNode: focusNode,
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(Icons.link),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(Icons.attach_money_outlined),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(Icons.camera_alt_outlined),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        chats.add(
                          ChatModel(
                              isSender: true,
                              msg: _controller.text,
                              name: "Mirza",
                              id: 0,
                              time: "12:00 PM",
                              isRely: true,
                              parentMsg: selectedChat?.msg ?? ""),
                        );
                        focusNode.unfocus();
                        selectedChat = null;
                        _controller.clear();
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.green.shade700,
                      radius: 22,
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReplyWidget(String msg) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: const Border(
              left: BorderSide(color: Colors.deepPurple, width: 3)),
          color: Colors.grey.shade100),
      child: Text(
        msg,
        maxLines: 3,
      ),
    );
  }
}
