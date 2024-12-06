import 'package:flutter/material.dart';
import 'dart:math';

class MoodPage extends StatelessWidget {
  final List<Map<String, String>> songDatabase = [
    {'title': 'Blue - yung kai', 'mood': 'Happy', 'language': 'English', 'genre': 'Pop'},
    {'title': 'Beautiful - Crush', 'mood': 'Happy', 'language': 'Korean', 'genre': 'Pop'},
    {'title': 'Let Her Go - Passenger', 'mood': 'Sad', 'language': 'English', 'genre': 'Acoustic'},
    {'title': 'Drunk - Keshi', 'mood': 'Relaxed', 'language': 'English', 'genre': 'R&B'},
    // Add more songs here
  ];

  final Map<String, List<String>> moodMessages = {
    'Happy': [
      'You’re like a walking sunshine! Keep glowing!',
      'Happiness is contagious, so pass it on!',
      'You’re not just happy—you’re *vibing*! 🎉',
    ],
    'Sad': [
      'Hey, it’s okay to have off days. You got this!',
      'Tough times don’t last, but tough people do. Hang in there!',
      'If you’re sad, just remember that pizza exists 🍕.',
    ],
    'Relaxed': [
      'Zen mode activated. Stay chill! ✨',
      'Peace and vibes only. Keep floating!',
      'Relaxed? You’re a whole vibe right now.',
    ],
  };

  @override
  Widget build(BuildContext context) {
    final userPreferences = ModalRoute.of(context)?.settings.arguments as Map;

    final List<Map<String, String>> moods = [
      {'name': 'Happy', 'image': 'assets/happy.png'},
      {'name': 'Sad', 'image': 'assets/sad.png'},
      {'name': 'Relaxed', 'image': 'assets/relaxed.png'},
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple.shade300, Colors.deepPurple.shade700],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(height: 20),

                  // Title
                  Text(
                    "How Are You Feeling Today?",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 4.0,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),

                  // Mood Cards
                  Expanded(
                    child: ListView.builder(
                      itemCount: moods.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: GestureDetector(
                            onTap: () {
                              _showMoodMessage(
                                context,
                                moods[index]['name']!,
                                moodMessages[moods[index]['name']]!,
                                moods[index]['image']!,
                                userPreferences,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8.0,
                                    spreadRadius: 2.0,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  // Mood Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: Image.asset(
                                      moods[index]['image']!,
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 10),

                                  // Mood Title
                                  Text(
                                    moods[index]['name']!,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple.shade900,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/playlist');
        },
        backgroundColor: Colors.pinkAccent,
        child: Icon(Icons.book, color: Colors.white),
      ),
    );
  }

  void _showMoodMessage(
      BuildContext context,
      String mood,
      List<String> messages,
      String image,
      Map userPreferences,
      ) {
    final randomMessage = messages[Random().nextInt(messages.length)];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple.shade50,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: EdgeInsets.all(20),
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/happie.png'),
                radius: 25,
              ),
              SizedBox(width: 10),
              Text(
                mood,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Text(
                randomMessage,
                style: TextStyle(fontSize: 18, color: Colors.deepPurple.shade700),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  '/playlist',
                  arguments: {
                    'mood': mood,
                    'playlist': _getSongsForMood(mood, userPreferences),
                  },
                );
              },
              child: Text(
                'Lessgoo',
                style: TextStyle(color: Colors.pinkAccent, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  List<String> _getSongsForMood(String mood, Map userPreferences) {
    return songDatabase
        .where((song) =>
    song['mood'] == mood &&
        song['language'] == userPreferences['language'] &&
        song['genre'] == userPreferences['genre'])
        .map((song) => song['title']!)
        .toList();
  }
}
