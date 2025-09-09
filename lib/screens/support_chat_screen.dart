import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SupportChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SupportChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // For contrast behind rounded body
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Support Chat',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.white),
                onPressed: () {},
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Please wait our support team will reply you as soon as possible.',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Text('KR'),
                    ),
                    title: Text('Kane Reene'),
                    subtitle: Text('Active 1m ago'),
                  ),
                  ChatBubble(
                    isUser: true,
                    text: 'Hey I need help!',
                    time: '08:15 AM',
                  ),
                  ChatBubble(
                    isUser: false,
                    text: 'Good morning! How Can I Help?',
                    time: '08:20 AM',
                  ),
                  ChatBubble(
                    isUser: true,
                    text:
                    'I ordered today, but I forgot to add some furniture, so how can I add more?',
                    time: '08:22 AM',
                  ),
                  ChatBubble(
                    isUser: false,
                    text:
                    'Ok, you just need to search for history and there you can see your order details.',
                    time: '08:25 AM',
                  ),
                  ChatBubble(
                    isUser: false,
                    text: 'You can edit anything there super fast 🔥',
                    time: '08:25 AM',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(icon: Icon(Icons.photo), onPressed: () {}),
                  IconButton(icon: Icon(Icons.mic), onPressed: () {}),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Aa',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.send), onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isUser;
  final String text;
  final String time;

  ChatBubble({required this.isUser, required this.text, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isUser ? Colors.orange : Colors.grey[200],
            borderRadius: isUser
                ? BorderRadius.circular(4) // Slightly rounded square
                : BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(color: isUser ? Colors.white : Colors.black),
              ),
              Text(
                time,
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
