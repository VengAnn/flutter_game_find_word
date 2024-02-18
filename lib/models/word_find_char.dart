// Define a class representing a character in the word puzzle
class WordFindChar {
  String? currentValue;
  int? currentIndex;
  String? correctValue;
  bool hintShow;

  WordFindChar({
    this.hintShow = false,
    this.correctValue,
    this.currentIndex,
    this.currentValue,
  });

  // Method to get the current value of the character
  String? getCurrentValue() {
    if (correctValue != null)
      return currentValue;
    else if (hintShow) return correctValue;
    return null;
  }

  // Method to clear the current value of the character
  void clearValue() {
    currentIndex = null;
    currentValue = null;
  }
}
