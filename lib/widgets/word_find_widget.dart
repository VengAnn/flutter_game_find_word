import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_game_wordfind_basic/models/word_find_char.dart';
import 'package:flutter_game_wordfind_basic/models/word_find_class.dart';
import 'package:word_search_safety/word_search_safety.dart';

class WordFindWidget extends StatefulWidget {
  final List<WordFindQues>? listQuestions;

  const WordFindWidget({Key? key, required this.listQuestions})
      : super(key: key);

  @override
  WordFindWidgetState createState() => WordFindWidgetState();
}

class WordFindWidgetState extends State<WordFindWidget> {
  late List<WordFindQues>? listQuestions;
  late WordFindQues? currentQues;
  late int indexQues; // Define indexQues here

  late int hintCount;

  @override
  void initState() {
    super.initState();
    listQuestions = widget.listQuestions;
    indexQues = 0; // Initialize indexQues
    hintCount = 0;
    generatePuzzle();
  }

  @override
  Widget build(BuildContext context) {
    if (listQuestions == null || listQuestions!.isEmpty) {
      // ignore: avoid_unnecessary_containers
      return Container(
        child: const Text("No questions available."),
      );
    }

    currentQues = listQuestions![indexQues];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => generateHint(),
                child: Icon(
                  Icons.healing_outlined,
                  size: 45,
                  color: Colors.yellow[200],
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () => generatePuzzle(left: true),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 45,
                      color: Colors.yellow[200],
                    ),
                  ),
                  InkWell(
                    onTap: () => generatePuzzle(next: true),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 45,
                      color: Colors.yellow[200],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.network(
              currentQues!.pathImage!,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "${currentQues!.question ?? ''}",
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: currentQues!.puzzles!.map((puzzle) {
              Color color;
              if (currentQues!.isDone)
                color = Colors.green[300]!;
              else if (puzzle.hintShow)
                color = Colors.yellow[100]!;
              else if (currentQues!.isFull)
                color = Colors.red;
              else
                color = Color(0xff7EE7FD);

              return InkWell(
                onTap: () {
                  if (puzzle.hintShow || currentQues!.isDone) return;
                  currentQues!.isFull = false;
                  puzzle.clearValue();
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: MediaQuery.of(context).size.width / 7 - 6,
                  height: MediaQuery.of(context).size.width / 7 - 6,
                  margin: const EdgeInsets.all(3),
                  child: Text(
                    // ignore: unnecessary_string_interpolations
                    "${puzzle.currentValue ?? ''}".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              crossAxisCount: 8,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: 16,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              bool statusBtn = currentQues!.puzzles!
                      .indexWhere((puzzle) => puzzle.currentIndex == index) >=
                  0;

              return Container(
                decoration: BoxDecoration(
                  color: statusBtn ? Colors.white70 : const Color(0xff7EE7FD),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: MaterialButton(
                  height: MediaQuery.of(context).size.height / 10,
                  child: Text(
                    "${currentQues!.arrayBtns![index]}".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    if (!statusBtn) setBtnClick(index);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void generatePuzzle({
    List<WordFindQues>? loop,
    bool next = false,
    bool left = false,
  }) {
    if (listQuestions == null || listQuestions!.isEmpty) return;

    if (loop != null) {
      indexQues = 0;
      listQuestions!.addAll(loop);
    } else {
      if (next && indexQues < listQuestions!.length - 1) {
        indexQues++;
      } else if (left && indexQues > 0) {
        indexQues--;
      } else if (indexQues >= listQuestions!.length - 1) {
        return;
      }

      if (listQuestions![indexQues].isDone) return;
    }

    WordFindQues currentQues = listQuestions![indexQues];
    final List<String> wl = [currentQues.answer!];
    final WSSettings ws = WSSettings(
      width: 16,
      height: 1,
      orientations: [WSOrientation.horizontal],
    );

    final WordSearchSafety wordSearch = WordSearchSafety();
    final WSNewPuzzle newPuzzle = wordSearch.newPuzzle(wl, ws);

    if (newPuzzle.errors!.isEmpty) {
      currentQues.arrayBtns = newPuzzle.puzzle!.expand((list) => list).toList();
      currentQues.arrayBtns!.shuffle();

      if (!currentQues.isDone) {
        currentQues.puzzles = List.generate(wl[0].split("").length, (index) {
          return WordFindChar(
            correctValue: currentQues.answer!.split("")[index],
          );
        });
      }
    }

    hintCount = 0;
    setState(() {});
  }

  void generateHint() async {
    WordFindQues currentQues = listQuestions![indexQues];

    List<WordFindChar> puzzleNoHints = currentQues.puzzles!
        .where((puzzle) => !puzzle.hintShow && puzzle.currentIndex == null)
        .toList();

    if (puzzleNoHints.isNotEmpty) {
      hintCount++;
      int indexHint = Random().nextInt(puzzleNoHints.length);
      int countTemp = 0;

      currentQues.puzzles = currentQues.puzzles!.map((puzzle) {
        if (!puzzle.hintShow && puzzle.currentIndex == null) countTemp++;

        if (indexHint == countTemp - 1) {
          puzzle.hintShow = true;
          puzzle.currentValue = puzzle.correctValue;
          puzzle.currentIndex = currentQues.arrayBtns!
              .indexWhere((btn) => btn == puzzle.correctValue);
        }

        return puzzle;
      }).toList();

      if (currentQues.fieldCompleteCorrect()) {
        currentQues.isDone = true;

        setState(() {});

        await Future.delayed(Duration(seconds: 1));
        generatePuzzle(next: true);
      }

      setState(() {});
    }
  }

  Future<void> setBtnClick(int index) async {
    WordFindQues currentQues = listQuestions![indexQues];

    int currentIndexEmpty = currentQues.puzzles!
        .indexWhere((puzzle) => puzzle.currentValue == null);

    if (currentIndexEmpty >= 0) {
      currentQues.puzzles![currentIndexEmpty].currentIndex = index;
      currentQues.puzzles![currentIndexEmpty].currentValue =
          currentQues.arrayBtns![index];

      if (currentQues.fieldCompleteCorrect()) {
        currentQues.isDone = true;

        setState(() {});

        await Future.delayed(Duration(seconds: 1));
        generatePuzzle(next: true);
      }
      setState(() {});
    }
  }
}
