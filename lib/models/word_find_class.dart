import 'package:flutter_game_wordfind_basic/models/word_find_char.dart';

// Define a class representing a word puzzle question
class WordFindQues {
  String? question;
  String? pathImage;
  String? answer;
  bool isDone = false;
  bool isFull = false;
  List<WordFindChar>? puzzles;
  List<String>? arrayBtns;

  WordFindQues({
    this.pathImage,
    this.question,
    this.answer,
    this.arrayBtns,
  });

  void setWordFindChar(List<WordFindChar> puzzles) => this.puzzles = puzzles;

  void setIsDone() => isDone = true;

  // Method to check if the word puzzle is complete and correct
  bool fieldCompleteCorrect() {
    // lets declare class WordFindChar 1st
    // check all field already got value
    // fix color red when value not full but show red color
    bool complete =
        // ignore: prefer_is_empty
        puzzles!.where((puzzle) => puzzle.currentValue == null).length == 0;

    if (!complete) {
      // no complete yet
      isFull = false;
      return complete;
    }

    isFull = true;
    // if already complete, check correct or not

    String answeredString =
        puzzles!.map((puzzle) => puzzle.currentValue).join("");

    // if same string, answer is correct..yeay
    return answeredString == answer;
  }

  // Method to clone a word puzzle question
  WordFindQues clone() {
    return WordFindQues(
      answer: answer,
      pathImage: pathImage,
      question: question,
    );
  }

  // lets generate sample question
}
