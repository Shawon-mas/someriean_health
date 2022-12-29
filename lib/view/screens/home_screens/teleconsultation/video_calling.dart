import 'package:flutter/material.dart';

import 'calling_page.dart';
class VideoCalling extends StatefulWidget {
  const VideoCalling({Key? key}) : super(key: key);

  @override
  State<VideoCalling> createState() => _VideoCallingState();
}

class _VideoCallingState extends State<VideoCalling> {
  final callIDTextCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: callIDTextCtrl,
                decoration:
                const InputDecoration(
                    hintText: "join a call by id",
                  border: OutlineInputBorder()
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return CallPage(callingId: callIDTextCtrl.text.toString());
                    }),
                  );
                },
                child: const Text("join"),
              )

            ],
          ),
        ),
      ),
    );
  }
}
