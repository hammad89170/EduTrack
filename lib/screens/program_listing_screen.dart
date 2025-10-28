import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProgramListingScreen extends StatefulWidget {
  const ProgramListingScreen({Key? key}) : super(key: key);

  @override
  State<ProgramListingScreen> createState() => _ProgramListingScreenState();
}

class _ProgramListingScreenState extends State<ProgramListingScreen> {
  List<dynamic> allPrograms = [];
  List<dynamic> enrolledPrograms = [];
  List<dynamic> availablePrograms = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPrograms();
  }

  Future<void> loadPrograms() async {
    await fetchPrograms();
    await loadEnrolledPrograms();
    separatePrograms();
  }

  Future<void> fetchPrograms() async {
    setState(() => isLoading = true);
    final response = await http.get(
      Uri.parse('https://mocki.io/v1/f637b121-9609-44c4-98e7-1e958edd3963'),
    );

    if (response.statusCode == 200) {
      setState(() {
        allPrograms = jsonDecode(response.body);
      });
    }
    setState(() => isLoading = false);
  }

  Future<void> loadEnrolledPrograms() async {
    final prefs = await SharedPreferences.getInstance();
    final enrolledIds = prefs.getStringList('enrolledPrograms') ?? [];
    enrolledPrograms = allPrograms
        .where((p) => enrolledIds.contains(p['id'].toString()))
        .toList();
  }

  Future<void> saveEnrolledPrograms() async {
    final prefs = await SharedPreferences.getInstance();
    final enrolledIds = enrolledPrograms.map((p) => p['id'].toString()).toList();
    await prefs.setStringList('enrolledPrograms', enrolledIds);
  }

  void separatePrograms() {
    setState(() {
      availablePrograms = allPrograms
          .where((p) => !enrolledPrograms.any((e) => e['id'] == p['id']))
          .toList();
    });
  }

  void joinProgram(dynamic program) async {
    setState(() {
      availablePrograms.remove(program);
      enrolledPrograms.add(program);
    });
    await saveEnrolledPrograms();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You have joined "${program['title']}" successfully! 🎉'),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void removeProgram(dynamic program) async {
    setState(() {
      enrolledPrograms.remove(program);
      availablePrograms.add(program);
    });
    await saveEnrolledPrograms();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You have left "${program['title']}" program.'),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget buildProgramCard(dynamic program, {bool showJoinButton = false, bool showRemoveButton = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.15),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              program['title'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              program['description'],
              style: const TextStyle(color: Colors.black87, fontSize: 14),
            ),
            const SizedBox(height: 10),
            if (showRemoveButton || !showJoinButton)
              LinearProgressIndicator(
                value: (program['progress'] ?? 0) * 1.0,
                color: Colors.blue,
                backgroundColor: Colors.blue.shade100,
              ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (showJoinButton)
                  ElevatedButton.icon(
                    onPressed: () => joinProgram(program),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.school, size: 18),
                    label: const Text("Join Now"),
                  ),
                if (showRemoveButton)
                  ElevatedButton.icon(
                    onPressed: () => removeProgram(program),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.delete, size: 18),
                    label: const Text("Remove"),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget buildGradientAppBar() {
    return AppBar(
      title: const Text("Programs"),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      elevation: 10,
    );
  }

  Widget shimmerLoader() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildGradientAppBar(),
      body: isLoading
          ? shimmerLoader()
          : RefreshIndicator(
        onRefresh: loadPrograms,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (enrolledPrograms.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "🎓 Enrolled Programs",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...enrolledPrograms
                      .map((p) => buildProgramCard(p, showRemoveButton: true))
                      .toList(),
                  const Divider(height: 30),
                ],
                const Center(
                  child: Text(
                    "📚 Available Programs",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ...availablePrograms
                    .map((p) => buildProgramCard(p, showJoinButton: true))
                    .toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
