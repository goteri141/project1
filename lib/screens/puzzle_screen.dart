import 'package:flutter/material.dart';
import '../models/chapter.dart';
import '../models/puzzle.dart';
import '../repositories/puzzle_repository.dart';
import '../repositories/session_repository.dart';
import 'leaderboard_screen.dart';

//final Chapter chapter;
//final String teamName;

List<Puzzle> puzzles = [];
int currentIndex = 0;
int hintsUsed = 0;

late DateTime startTime;

final TextEditingController answerController = TextEditingController();