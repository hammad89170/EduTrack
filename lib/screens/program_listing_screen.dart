import 'package:flutter/material.dart';

class ProgramListScreen extends StatelessWidget {
  const ProgramListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> programs = [
      {
        "title": "AI Basics",
        "logo": "assets/images/networking.png",
        "description": "Learn the fundamentals of Artificial Intelligence.",
        "progress": 0.6,
      },
      {
        "title": "Networking 101",
        "logo": "assets/images/networking.png",
        "description": "Understand the basics of networking and protocols.",
        "progress": 0.3,
      },
      {
        "title": "Web Development",
        "logo": "assets/images/web logo.png",
        "description": "Build responsive websites using HTML, CSS, and JS.",
        "progress": null, // not enrolled
      },
      {
        "title": "Cyber Security Essentials",
        "logo": "assets/images/networking.png",
        "description": "Protect systems and data from security threats.",
        "progress": 0.75,
      },
      {
        "title": "Cloud Computing",
        "logo": "assets/images/networking.png",
        "description": "Learn about AWS, Azure, and cloud infrastructures.",
        "progress": null, // not enrolled
      },
      {
        "title": "Data Science Bootcamp",
        "logo": "assets/images/networking.png",
        "description": "Master data analysis, visualization, and ML basics.",
        "progress": 0.45,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Programs",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2193b0),
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: programs.length,
          itemBuilder: (context, index) {
            final program = programs[index];
            final bool isEnrolled = program["progress"] != null;

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      program["logo"],
                      height: 60,
                      width: 60,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            program["title"],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            program["description"],
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 10),

                          // Show progress bar or join button based on enrollment
                          if (isEnrolled) ...[
                            LinearProgressIndicator(
                              value: program["progress"],
                              backgroundColor: Colors.blue.shade100,
                              color: const Color(0xFF2193b0),
                              borderRadius: BorderRadius.circular(10),
                              minHeight: 8,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${((program["progress"] as double) * 100).toInt()}% Completed",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ] else
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2193b0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  // TODO: Navigate to program details
                                },
                                child: const Text("Join Now"),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
