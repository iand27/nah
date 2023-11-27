import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maimuna/models/note_data.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import 'editing_note_page.dart';
import 'from_me_to_you.dart';
import 'novel_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initializeNotes();
  }

  // buat catatan baru
  void createNewNote() {
    // buat id baru
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    // datetime now

    // buat catatan  kosong
    Note newNote = Note(
      id: id,
      text: '',
      time: '',
    );

    // go to edit catatan
    goToNotePage(newNote, true);
  }

  // go to halaman edit catatan
  void goToNotePage(Note note, bool isNewNote) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditingNotePage(
          note: note,
          isNewNote: isNewNote,
        ),
      ),
    );
  }

  // hapus catatan
  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: createNewNote,
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: const Icon(
            Icons.note_alt_outlined,
            color: Colors.grey,
          ),
        ),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // heading
            Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FromMeToYou(),
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/maimuna.png',
                      height: 32.0,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NovelPage(),
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/lucas.png',
                      height: 32.0,
                    ),
                  ),
                ],
              ),
            ),

            // SPECIAL
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'You deserve all the good things \n my lovely girl',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.black54,
                  ),
                ),
                Image.asset(
                  'assets/images/lline.png',
                  height: 20.0,
                ),
              ],
            ),

            // list catatan
            value.getAllNotes().length == 0
                ? Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Center(
                      child: Text(
                        'Start Writing Maimuna :)',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: SingleChildScrollView(
                        child: CupertinoListSection.insetGrouped(
                          children: List.generate(
                            value.getAllNotes().length,
                            (index) => Dismissible(
                              background: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              onDismissed: (DismissDirection direction) {
                                setState(() {
                                  deleteNote(value.getAllNotes()[index]);
                                });
                              },
                              child: CupertinoListTile(
                                leading:
                                    Image.asset('assets/images/leaf02.png'),
                                title: Text(
                                  value.getAllNotes()[index].text,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                subtitle: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/leaf01.png',
                                      height: 10.0,
                                    ),
                                    SizedBox(width: 6.0),
                                    // Text('Waktu'),
                                    Text(value.getAllNotes()[index].time),
                                  ],
                                ),
                                onTap: () => goToNotePage(
                                    value.getAllNotes()[index], false),
                                // trailing: IconButton(
                                //   icon: Icon(
                                //     Icons.delete,
                                //     color: Colors.grey[400],
                                //   ),
                                //   onPressed: () =>
                                //       deleteNote(value.getAllNotes()[index]),
                                // ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
