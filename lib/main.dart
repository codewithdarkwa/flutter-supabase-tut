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
              return ListTile(
                title: Text(note['body']),
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
                      onFieldSubmitted: (value) async {
                        await supabase.from('notes').insert({'body': value});
                      },
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
