import 'package:flutter/material.dart';
import '../models/session.dart';
import '../repositories/session_repository.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {

  final SessionRepository sessionRepository = SessionRepository();

  late Future<List<Session>> sessionsFuture;

  @override
  void initState() {
    super.initState();
    sessionsFuture = sessionRepository.getLeaderboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leaderboard"),
      ),
      body: FutureBuilder<List<Session>>(
        future: sessionsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final sessions = snapshot.data!;

          if (sessions.isEmpty) {
            return const Center(child: Text("No completed sessions yet."));
          }

          return ListView.builder(
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              final duration = session.endTime != null
                  ? Duration(milliseconds: session.endTime! - session.startTime)
                  : null;
              final timeStr = duration != null
                  ? '${duration.inMinutes}m ${duration.inSeconds % 60}s'
                  : 'N/A';

              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(session.teamName),
                subtitle: Text('Hints used: ${session.hintsUsed}  •  Time: $timeStr'),
              );
            },
          );
        },
      ),
    );
  }
}