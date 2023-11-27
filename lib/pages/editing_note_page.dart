import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:maimuna/models/note_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import '../models/note.dart';

class EditingNotePage extends StatefulWidget {
  Note note;
  bool isNewNote;
  EditingNotePage({
    super.key,
    required this.note,
    required this.isNewNote,
  });

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  QuillController _controller = QuillController.basic();
  int timestamp = DateTime.now().millisecondsSinceEpoch;

  @override
  void initState() {
    super.initState();
    loadExistingNote();
  }

  // load catatan yang sudah ada
  void loadExistingNote() {
    final doc = Document()..insert(0, widget.note.text);
    setState(() {
      _controller = QuillController(
          document: doc, selection: const TextSelection.collapsed(offset: 0));
    });
  }

  // tambah cataan baru
  void addNewNote() {
    // get id baru
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    // get text dari editor
    String text = _controller.document.toPlainText();

    // waktu
    // int timestamp = DateTime.now().millisecondsSinceEpoch;
    DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String datetime = tsdate.year.toString() +
        "-" +
        tsdate.month.toString() +
        "-" +
        tsdate.day.toString();
    // add catatan baru
    Provider.of<NoteData>(context, listen: false).addNewNote(
      Note(
        id: id,
        text: text,
        time: datetime,
      ),
    );
  }

  // update catatan yang sudah ada
  void updateNote() {
    // get text dari editor
    String text = _controller.document.toPlainText();
    // waktu
    // int timestamp = DateTime.now().millisecondsSinceEpoch;
    DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String datetime = tsdate.year.toString() +
        "-" +
        tsdate.month.toString() +
        "-" +
        tsdate.day.toString();
    // update catatan
    Provider.of<NoteData>(context, listen: false)
        .updateNote(widget.note, text, datetime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            // apakah catatan baru
            if (widget.isNewNote && !_controller.document.isEmpty()) {
              addNewNote();
            }

            // apakah catatan yang sudah ada
            else {
              updateNote();
            }

            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          // toolbar
          QuillToolbar.basic(
            controller: _controller,
            showAlignmentButtons: false,
            showBackgroundColorButton: false,
            showCenterAlignment: false,
            showColorButton: false,
            showCodeBlock: false,
            showDirection: false,
            showFontFamily: false,
            showDividers: false,
            showIndent: false,
            showHeaderStyle: false,
            showLink: false,
            showSearchButton: false,
            showInlineCode: false,
            showQuote: false,
            showListNumbers: false,
            showListBullets: false,
            showClearFormat: false,
            showBoldButton: false,
            showFontSize: false,
            showItalicButton: false,
            showUnderLineButton: false,
            showStrikeThrough: false,
            showListCheck: false,
          ),

          // editor
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(25.0),
              child: QuillEditor.basic(
                controller: _controller,
                readOnly: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
