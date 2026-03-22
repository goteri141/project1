import "../models/puzzle.dart";

final List storyPuzzles = [
  Puzzle(
    id: 001,
    chapterId: 01,
    question: "I have keys but no locks,\nI have space but no room,\nYou can enter, but you can't go outside.\nWhat am I?",
    answer: ["keypad", 'key', 'keylock'],
    hint: "It has keys, but it is not used to unlock doors."
  ),

  Puzzle(
    id: 002,
    chapterId: 02,
    question: "I am wrapped around a red beauty guarding them from harm.\nIf they get too close, they might bleed.\n What am I?",
    answer: ['thorn', 'thorns'],
    hint: "It's green."
  ),

  Puzzle(
    id: 003,
    chapterId: 03,
    question: "The more you take, the more you leave behind.\nWhat am I?",
    answer: ["footstep", "footsteps", 'steps'],
    hint: "It's something you left behind as you move."
  ),

  Puzzle(
    id: 004,
    chapterId: 04,
    question: "I hang but never fall,\nI watch but have no eyes,\nI tell stories without a voice.\nWhat am I?",
    answer: ["portrait", "painting"],
    hint: "It sees you without eyes... "
  ),

  Puzzle(
    id: 005,
    chapterId: 05,
    question: "I keep your secrets safe at night,\nI hold your thoughts out of sight.\nI have no voice, yet I speak your mind.\nWhat am I?",
    answer: ["diary", 'journal'],
    hint: "It's a kind of book."
  ),
];