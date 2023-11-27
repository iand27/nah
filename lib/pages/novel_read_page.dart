import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/novel.dart';
import '../models/novel_chapter.dart';

class NovelReadPage extends StatefulWidget {
  final NovelChapter chapters;
  final Novel novel;
  const NovelReadPage({
    super.key,
    required this.chapters,
    required this.novel,
  });

  @override
  State<NovelReadPage> createState() => _NovelReadPageState();
}

class _NovelReadPageState extends State<NovelReadPage> {
  String data = '';
  fetchFileData(String chap) async {
    String res;
    res = await rootBundle.loadString(chap);

    setState(() {
      data = res;
    });
  }

  @override
  void initState() {
    fetchFileData(widget.chapters.isi.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.novel.judul,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15.0, bottom: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/images/leaf03.png', height: 10.0),
                const SizedBox(width: 8.0),
                Text(
                  widget.chapters.chapterke,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  data,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
