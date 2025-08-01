// import 'package:flutter/material.dart';
// import 'package:setnotes/note.dart';
// import 'package:setnotes/noteedit.dart';
// import 'package:setnotes/stagged.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert'; // Required for json encoding/decoding


// class KeepNotesApp extends StatefulWidget {
//   const KeepNotesApp({super.key});

//   @override
//   _KeepNotesAppState createState() => _KeepNotesAppState();
// }

// class _KeepNotesAppState extends State<KeepNotesApp> {
//   List<Note> notes = [];
//   List<Note> filteredNotes = [];
//   bool isGridView = true;
//   bool isSearching = false;
//   TextEditingController searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _loadNotes(); // Load notes when the app starts
//     searchController.addListener(_filterNotes);
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   // Filter notes based on search query
//   void _filterNotes() {
//     String query = searchController.text.toLowerCase();
//     setState(() {
//       if (query.isEmpty) {
//         filteredNotes = List.from(notes);
//       } else {
//         filteredNotes = notes.where((note) {
//           return note.title.toLowerCase().contains(query) ||
//               note.content.toLowerCase().contains(query);
//         }).toList();
//       }
//     });
//   }

//   // Load notes from Shared Preferences
//   Future<void> _loadNotes() async {
//     final prefs = await SharedPreferences.getInstance();
//     final notesString = prefs.getString('notes');
//     if (notesString != null) {
//       final List<dynamic> notesJson = json.decode(notesString);
//       setState(() {
//         notes = notesJson.map((noteJson) => Note.fromJson(noteJson)).toList();
//         filteredNotes = List.from(notes);
//       });
//     }
//   }

//   // Save notes to Shared Preferences
//   Future<void> _saveNotes() async {
//     final prefs = await SharedPreferences.getInstance();
//     final notesString = json.encode(notes.map((note) => note.toJson()).toList());
//     await prefs.setString('notes', notesString);
//   }

//   void _deleteNote(String noteId) {
//     setState(() {
//       notes.removeWhere((note) => note.id == noteId);
//       filteredNotes.removeWhere((note) => note.id == noteId);
//     });
//     _saveNotes(); // Save notes after deletion
//   }

//   void _toggleView() {
//     setState(() {
//       isGridView = !isGridView;
//     });
//   }

//   void _toggleSearch() {
//     setState(() {
//       isSearching = !isSearching;
//       if (!isSearching) {
//         searchController.clear();
//         filteredNotes = List.from(notes);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF202124),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF202124),
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         title: isSearching
//             ? Container(
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF303134),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: TextField(
//                   controller: searchController,
//                   autofocus: true,
//                   style: const TextStyle(color: Colors.white, fontSize: 16),
//                   decoration: InputDecoration(
//                     hintText: 'Search your notes',
//                     hintStyle: TextStyle(color: Colors.grey[400]),
//                     border: InputBorder.none,
//                     contentPadding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                     prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 20),
//                   ),
//                 ),
//               )
//             : GestureDetector(
//                 onTap: _toggleSearch,
//                 child: Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF303134),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16, right: 8),
//                         child: Icon(Icons.search, color: Colors.grey[400], size: 20),
//                       ),
//                       Text(
//                         'Search your notes',
//                         style: TextStyle(
//                           color: Colors.grey[400],
//                           fontSize: 16,
//                           fontWeight: FontWeight.normal,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//         actions: [
//           if (isSearching)
//             IconButton(
//               icon: const Icon(Icons.close, color: Colors.white),
//               onPressed: _toggleSearch,
//             )
//           else ...[
//             IconButton(
//               icon: Icon(
//                 isGridView ? Icons.view_agenda : Icons.grid_view,
//                 color: Colors.white,
//               ),
//               onPressed: () => _toggleView(),
//             ),
//           ],
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: filteredNotes.isEmpty
//             ? Center(
//                 child: Text(
//                   searchController.text.isNotEmpty
//                       ? 'No notes found\nTry a different search term'
//                       : 'No notes yet\nTap + to create your first note',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.grey[500],
//                     fontSize: 16,
//                   ),
//                 ),
//               )
//             : isGridView
//                 ? StaggeredGridView(
//                     notes: filteredNotes,
//                     onNoteDeleted: _deleteNote,
//                     onNoteEdited: _editNote,
//                   )
//                 : ListView.builder(
//                     itemCount: filteredNotes.length,
//                     itemBuilder: (context, index) {
//                       return Container(
//                         margin: const EdgeInsets.symmetric(vertical: 4),
//                         decoration: BoxDecoration(
//                           color: filteredNotes[index].color,
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: Colors.grey[300]!),
//                         ),
//                         child: ListTile(
//                           title: Text(
//                             filteredNotes[index].title.isEmpty
//                                 ? 'Untitled'
//                                 : filteredNotes[index].title,
//                             style: const TextStyle(
//                                 color: Colors.black87, fontWeight: FontWeight.bold),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           subtitle: Text(
//                             filteredNotes[index].content,
//                             style: const TextStyle(color: Colors.black54),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           onTap: () => _editNote(filteredNotes[index]),
//                           trailing: PopupMenuButton(
//                             icon: const Icon(Icons.more_vert, color: Colors.black54),
//                             color: const Color(0xFF303134),
//                             itemBuilder: (context) => [
//                               const PopupMenuItem(
//                                 value: 'edit',
//                                 child: Text('Edit', style: TextStyle(color: Colors.white)),
//                               ),
//                               const PopupMenuItem(
//                                 value: 'delete',
//                                 child: Text('Delete', style: TextStyle(color: Colors.red)),
//                               ),
//                             ],
//                             onSelected: (value) {
//                               if (value == 'edit') {
//                                 _editNote(filteredNotes[index]);
//                               } else if (value == 'delete') {
//                                 _deleteNote(filteredNotes[index].id);
//                               }
//                             },
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _addNewNote,
//         backgroundColor: const Color(0xFF2D2E30),
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//     );
//   }

//   void _addNewNote() {
//     final newNote = Note(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       content: '',
//       title: '',
//       color: Colors.white,
//       createdTime: DateTime.now(),
//     );
//     setState(() {
//       notes.insert(0, newNote);
//       filteredNotes.insert(0, newNote);
//     });
//     _saveNotes(); // Save notes after adding
//     _editNote(newNote);
//   }

//   void _editNote(Note note) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => NoteEditScreen(
//           note: note,
//           onNoteUpdated: () {
//             setState(() {
//               // Update the note in both lists
//               int noteIndex = notes.indexWhere((n) => n.id == note.id);
//               if (noteIndex != -1) {
//                 notes[noteIndex] = note;
//               }
//               _filterNotes(); // Re-filter notes after update
//             });
//             _saveNotes(); // Save notes after update
//           },
//           onNoteDeleted: _deleteNote,
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:setnotes/note.dart';
import 'package:setnotes/noteedit.dart';
import 'package:setnotes/stagged.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Required for json encoding/decoding


class KeepNotesApp extends StatefulWidget {
  const KeepNotesApp({super.key});

  @override
  _KeepNotesAppState createState() => _KeepNotesAppState();
}

class _KeepNotesAppState extends State<KeepNotesApp> {
  List<Note> notes = [];
  List<Note> filteredNotes = [];
  bool isGridView = true;
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadNotes(); // Load notes when the app starts
    searchController.addListener(_filterNotes);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Filter notes based on search query
  void _filterNotes() {
    String query = searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredNotes = List.from(notes);
      } else {
        filteredNotes = notes.where((note) {
          return note.title.toLowerCase().contains(query) ||
              note.content.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  // Load notes from Shared Preferences
  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesString = prefs.getString('notes');
    if (notesString != null) {
      final List<dynamic> notesJson = json.decode(notesString);
      setState(() {
        notes = notesJson.map((noteJson) => Note.fromJson(noteJson)).toList();
        filteredNotes = List.from(notes);
      });
    }
  }

  // Save notes to Shared Preferences
  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesString = json.encode(notes.map((note) => note.toJson()).toList());
    await prefs.setString('notes', notesString);
  }

  void _deleteNote(String noteId) {
    setState(() {
      notes.removeWhere((note) => note.id == noteId);
      filteredNotes.removeWhere((note) => note.id == noteId);
    });
    _saveNotes(); // Save notes after deletion
  }

  void _toggleView() {
    setState(() {
      isGridView = !isGridView;
    });
  }

  void _toggleSearch() {
    setState(() {
      isSearching = !isSearching;
      if (!isSearching) {
        searchController.clear();
        filteredNotes = List.from(notes);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202124),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202124),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: isSearching
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF303134),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: searchController,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Search your notes',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 20),
                  ),
                ),
              )
            : GestureDetector(
                onTap: _toggleSearch,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF303134),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        child: Icon(Icons.search, color: Colors.grey[400], size: 20),
                      ),
                      Text(
                        'Search your notes',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        actions: [
          if (isSearching)
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: _toggleSearch,
            )
          else ...[
            IconButton(
              icon: Icon(
                isGridView ? Icons.view_agenda : Icons.grid_view,
                color: Colors.white,
              ),
              onPressed: () => _toggleView(),
            ),
          ],
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: filteredNotes.isEmpty
            ? Center(
                child: Text(
                  searchController.text.isNotEmpty
                      ? 'No notes found\nTry a different search term'
                      : 'No notes yet\nTap + to create your first note',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 16,
                  ),
                ),
              )
            : isGridView
                ? StaggeredGridView(
                    notes: filteredNotes,
                    onNoteDeleted: _deleteNote,
                    onNoteEdited: _editNote,
                  )
                : ListView.builder(
                    itemCount: filteredNotes.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: filteredNotes[index].color,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: ListTile(
                          title: Text(
                            filteredNotes[index].title.isEmpty
                                ? 'Untitled'
                                : filteredNotes[index].title,
                            style: const TextStyle(
                                color: Colors.black87, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            filteredNotes[index].content,
                            style: const TextStyle(color: Colors.black54),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () => _editNote(filteredNotes[index]),
                          trailing: PopupMenuButton(
                            icon: const Icon(Icons.more_vert, color: Colors.black54),
                            color: const Color(0xFF303134),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text('Edit', style: TextStyle(color: Colors.white)),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete', style: TextStyle(color: Colors.red)),
                              ),
                            ],
                            onSelected: (value) {
                              if (value == 'edit') {
                                _editNote(filteredNotes[index]);
                              } else if (value == 'delete') {
                                _deleteNote(filteredNotes[index].id);
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewNote,
        backgroundColor: const Color(0xFF2D2E30),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _addNewNote() {
    final newNote = Note(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: '',
      title: '',
      color: Colors.white,
      createdTime: DateTime.now(),
    );
    setState(() {
      notes.insert(0, newNote);
      filteredNotes.insert(0, newNote);
    });
    _saveNotes(); // Save notes after adding
    _editNote(newNote);
  }

  void _editNote(Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditScreen(
          note: note,
          onNoteUpdated: () {
            setState(() {
              // Update the note in both lists
              int noteIndex = notes.indexWhere((n) => n.id == note.id);
              if (noteIndex != -1) {
                notes[noteIndex] = note;
              }
              _filterNotes(); // Re-filter notes after update
            });
            _saveNotes(); // Save notes after update
          },
          onNoteDeleted: _deleteNote,
        ),
      ),
    );
  }
}
