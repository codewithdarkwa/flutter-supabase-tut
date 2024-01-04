import 'package:flutter/material.dart';
import 'package:flutter_supabase/login.dart';
import 'package:flutter_supabase/signup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://swnojhycpnkbojqczxbe.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN3bm9qaHljcG5rYm9qcWN6eGJlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQxMDI5MjQsImV4cCI6MjAxOTY3ODkyNH0.YcJoahPlqk4mSzrdwvAmdOu3s7VDOAwcaqp51Em1B34',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignUpPage(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final noteStream = supabase.from('notes').stream(primaryKey: ['id']);

  //Sign Out User
  Future<void> signOut() async {
    await supabase.auth.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  //Create a note
  Future<void> createNote(String note) async {
    await supabase.from('notes').insert({'body': note});
  }

  // Update Note
  Future<void> updateNote(String noteId, String updatedBody) async {
    await supabase.from('notes').update({'body': updatedBody}).eq('id', noteId);
  }

  // Delete Note
  Future<void> deleteNote(String noteId) async {
    await supabase.from('notes').delete().eq('id', noteId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: noteStream,
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final notes = snapshot.data!;

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              final noteId = note['id'].toString();

              return ListTile(
                title: Text(note['body']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Trigger update note dialog
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              title: const Text('Update note'),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                              children: [
                                TextFormField(
                                  initialValue: note['body'],
                                  onFieldSubmitted: (value) async {
                                    await updateNote(noteId, value);
                                    if(mounted) Navigator.pop(context); // Close the dialog
                                  },
                                )
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () async {
                        // Trigger delete note confirmation
                        bool deleteConfirmed = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Delete note?'),
                              content: const Text('Are you sure you want to delete this note?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                        if (deleteConfirmed != null && deleteConfirmed) {
                          await deleteNote(noteId);
                        }
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  title: const Text('Add a new note'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  children: [
                    TextFormField(
                      onFieldSubmitted: createNote,
                    )
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
