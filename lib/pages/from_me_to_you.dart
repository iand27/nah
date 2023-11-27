import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FromMeToYou extends StatelessWidget {
  const FromMeToYou({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Text(
              '20th',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Image.asset(
              'assets/images/love02.png',
              height: 14.0,
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 12.0),
        child: Column(
          children: [
            const Text(
              'Alhamdulillah\n\nDear My Lovely Girl\n\nI know that I really love you and I am aware of that\n\nProblems will always be there in this relationship\nbut I hope that these problems will not have too much of an impact on this relationship\nthat I really care for.\n\nI will not wish the best for you\n\nBut I will make sure to always be there in every situation you are in -\nWhether it is happy, sad, happy, grieving, falling, waking up, not the best and the best.\n\nBismillah - Insha Allah\n\nFromMeToYou',
              style: TextStyle(fontSize: 12.0),
            ),
            const SizedBox(height: 12.0),
            Align(
              alignment: Alignment.centerRight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset('assets/images/i3.png', height: 180.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
