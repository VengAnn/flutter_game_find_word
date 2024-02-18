// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:word_search_safety/word_search_safety.dart';

// class WordFind extends StatefulWidget {
//   const WordFind({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _WordFindState createState() => _WordFindState();
// }

// class _WordFindState extends State<WordFind> {
//   // sent size to our widget
//   GlobalKey<_WordFindWidgetState> globalKey = GlobalKey();

//   // make list question for puzzle
//   // make class 1st
//   late List<WordFindQues> listQuestions;

//   @override
//   void initState() {
//     super.initState();
//     listQuestions = [
//       WordFindQues(
//         question: "What is name of this game?",
//         answer: "mario",
//         pathImage:
//             "https://images.pexels.com/photos/163077/mario-yoschi-figures-funny-163077.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
//       ),
//       WordFindQues(
//         question: "What is this animal?",
//         answer: "cat",
//         pathImage:
//             "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
//       ),
//       WordFindQues(
//         question: "What is this animal name?",
//         answer: "wolf",
//         pathImage:
//             "https://as1.ftcdn.net/v2/jpg/02/48/64/04/1000_F_248640483_5KAZi0GqcWrBu6GOhFEAxk1quNEuOzHJ.jpg",
//       )
//       // let me find online image 1st
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           color: Colors.green,
//           child: Column(
//             children: [
//               Expanded(
//                 child: LayoutBuilder(
//                   builder: (context, constraints) {
//                     return Container(
//                       color: Colors.blue,
//                       // lets make our word find widget
//                       // sent list to our widget
//                       child: WordFindWidget(
//                         constraints.biggest,
//                         listQuestions, // Pass listQuestions directly
//                         key: globalKey,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               // ignore: avoid_unnecessary_containers
//               Container(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // reload btn test
//                     globalKey.currentState!.generatePuzzle(
//                       loop: listQuestions.map((ques) => ques.clone()).toList(),
//                     );
//                   },
//                   child: const Text("reload"),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // make statefull widget name WordFindWidget
// // ignore: must_be_immutable
// class WordFindWidget extends StatefulWidget {
//   Size? size;
//   List<WordFindQues>? listQuestions;

//   WordFindWidget(
//     Size? size,
//     List<WordFindQues>? list, {
//     Key? key,
//   }) : super(key: key) {
//     this.size = size;
//     this.listQuestions = list;
//   }

//   @override
//   _WordFindWidgetState createState() => _WordFindWidgetState();
// }

// class _WordFindWidgetState extends State<WordFindWidget> {
//   Size? size;
//   List<WordFindQues>? listQuestions;
//   int indexQues = 0; // current index question
//   int hintCount = 0;

//   // thanks for watching.. :)

//   WordFindQues? currentQues;

//   @override
//   void initState() {
//     super.initState();
//     size = widget.size;
//     listQuestions = widget.listQuestions;
//     generatePuzzle(); // Move this line to after listQuestions is initialized
//   }

//   @override
//   Widget build(BuildContext context) {
//     // lets make ui
//     // let put current data on question
//     if (listQuestions == null || listQuestions!.isEmpty) {
//       return Container(
//         child: Text("null listQuestions"),
//       ); // Or any other appropriate widget to handle this case
//     }

//     currentQues = listQuestions![indexQues];
//     // print(currentQues);

//     return Container(
//       width: double.maxFinite,
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                   onTap: () => generateHint(),
//                   child: Icon(
//                     Icons.healing_outlined,
//                     size: 45,
//                     color: Colors.yellow[200],
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     InkWell(
//                       onTap: () => generatePuzzle(left: true),
//                       child: Icon(
//                         Icons.arrow_back_ios,
//                         size: 45,
//                         color: Colors.yellow[200],
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () => generatePuzzle(next: true),
//                       child: Icon(
//                         Icons.arrow_forward_ios,
//                         size: 45,
//                         color: Colors.yellow[200],
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//           Expanded(
//             child: Container(
//               alignment: Alignment.center,
//               padding: EdgeInsets.all(10),
//               child: Container(
//                 alignment: Alignment.center,
//                 constraints: BoxConstraints(
//                   maxWidth: size!.width / 2 * 1.5,
//                   // maxHeight: size.width / 2.5,
//                 ),
//                 child: Image.network(
//                   currentQues!.pathImage!,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(10),
//             alignment: Alignment.center,
//             child: Text(
//               "${currentQues!.question ?? ''}",
//               style: TextStyle(
//                 fontSize: 25,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
//             alignment: Alignment.center,
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 return Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.max,
//                   children: currentQues!.puzzles!.map((puzzle) {
//                     // later change color based condition
//                     Color color;

//                     if (currentQues!.isDone)
//                       color = Colors.green[300]!;
//                     else if (puzzle.hintShow)
//                       color = Colors.yellow[100]!;
//                     else if (currentQues!.isFull)
//                       color = Colors.red;
//                     else
//                       color = Color(0xff7EE7FD);

//                     return InkWell(
//                       onTap: () {
//                         if (puzzle.hintShow || currentQues!.isDone) return;

//                         currentQues!.isFull = false;
//                         puzzle.clearValue();
//                         setState(() {});
//                       },
//                       child: Container(
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: color,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         width: constraints.biggest.width / 7 - 6,
//                         height: constraints.biggest.width / 7 - 6,
//                         margin: const EdgeInsets.all(3),
//                         child: Text(
//                           "${puzzle.currentValue ?? ''}".toUpperCase(),
//                           style: TextStyle(
//                             fontSize: 25,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 );
//               },
//             ),
//           ),
//           // this box select text to fill word
//           Container(
//             padding: const EdgeInsets.all(10),
//             alignment: Alignment.center,
//             child: GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 childAspectRatio: 1,
//                 crossAxisCount: 8,
//                 crossAxisSpacing: 4,
//                 mainAxisSpacing: 4,
//               ),
//               itemCount: 16, // later change
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 bool statusBtn = currentQues!.puzzles!
//                         .indexWhere((puzzle) => puzzle.currentIndex == index) >=
//                     0;

//                 return LayoutBuilder(
//                   builder: (context, constraints) {
//                     Color color =
//                         statusBtn ? Colors.white70 : const Color(0xff7EE7FD);

//                     return Container(
//                       decoration: BoxDecoration(
//                         color: color,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       // margin: ,
//                       alignment: Alignment.center,
//                       child: MaterialButton(
//                         height: constraints.biggest.height,
//                         child: Text(
//                           // ignore: unnecessary_string_interpolations
//                           "${currentQues!.arrayBtns![index]}".toUpperCase(),
//                           style: const TextStyle(
//                             fontSize: 25,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         onPressed: () {
//                           if (!statusBtn) setBtnClick(index);
//                         },
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void generatePuzzle({
//     List<WordFindQues>? loop,
//     bool next = false,
//     bool left = false,
//   }) {
//     // Ensure listQuestions is not null and not empty before proceeding
//     if (listQuestions == null || listQuestions!.isEmpty) return;

//     if (loop != null) {
//       // Reset index and replace the list of questions if loop is provided
//       indexQues = 0;
//       listQuestions!.addAll(loop);
//     } else {
//       // Move to the next or previous question if applicable
//       if (next && indexQues < listQuestions!.length - 1) {
//         indexQues++;
//       } else if (left && indexQues > 0) {
//         indexQues--;
//       } else if (indexQues >= listQuestions!.length - 1) {
//         // Return if at the last question and attempting to go next
//         return;
//       }

//       if (listQuestions![indexQues].isDone) return;
//     }

//   // Retrieve the current question
//     WordFindQues currentQues = listQuestions![indexQues];

//     final List<String> wl = [currentQues.answer!];

//     final WSSettings ws = WSSettings(
//       width: 16, // total random word row we want use
//       height: 1,
//       orientations: List.from([
//         WSOrientation.horizontal,
//       ]),
//     );

//     final WordSearchSafety wordSearch = WordSearchSafety();

//     final WSNewPuzzle newPuzzle = wordSearch.newPuzzle(wl, ws);

//     if (newPuzzle.errors!.isEmpty) {
//       currentQues.arrayBtns = newPuzzle.puzzle!.expand((list) => list).toList();
//       currentQues.arrayBtns!.shuffle(); // make shuffle so user not know answer

//       bool isDone = currentQues.isDone;

//       if (!isDone) {
//         currentQues.puzzles = List.generate(wl[0].split("").length, (index) {
//           return WordFindChar(
//             correctValue: currentQues.answer!.split("")[index],
//           );
//         });
//       }
//     }

//     hintCount = 0; // number hint per ques we hit
//     setState(() {});
//   }

//   generateHint() async {
//     // let dclare hint
//     WordFindQues currentQues = listQuestions![indexQues];

//     List<WordFindChar> puzzleNoHints = currentQues.puzzles!
//         .where((puzzle) => !puzzle.hintShow && puzzle.currentIndex == null)
//         .toList();

//     if (puzzleNoHints.length > 0) {
//       hintCount++;
//       int indexHint = Random().nextInt(puzzleNoHints.length);
//       int countTemp = 0;
//       // print("hint $indexHint");

//       currentQues.puzzles = currentQues.puzzles!.map((puzzle) {
//         if (!puzzle.hintShow && puzzle.currentIndex == null) countTemp++;

//         if (indexHint == countTemp - 1) {
//           puzzle.hintShow = true;
//           puzzle.currentValue = puzzle.correctValue;
//           puzzle.currentIndex = currentQues.arrayBtns!
//               .indexWhere((btn) => btn == puzzle.correctValue);
//         }

//         return puzzle;
//       }).toList();

//       // check if complete

//       if (currentQues.fieldCompleteCorrect()) {
//         currentQues.isDone = true;

//         setState(() {});

//         await Future.delayed(Duration(seconds: 1));
//         generatePuzzle(next: true);
//       }

//       // my wrong..not refresh.. damn..haha
//       setState(() {});
//     }
//   }

//   Future<void> setBtnClick(int index) async {
//     WordFindQues currentQues = listQuestions![indexQues];

//     int currentIndexEmpty = currentQues.puzzles!
//         .indexWhere((puzzle) => puzzle.currentValue == null);

//     if (currentIndexEmpty >= 0) {
//       currentQues.puzzles![currentIndexEmpty].currentIndex = index;
//       currentQues.puzzles![currentIndexEmpty].currentValue =
//           currentQues.arrayBtns![index];

//       if (currentQues.fieldCompleteCorrect()) {
//         currentQues.isDone = true;

//         setState(() {});

//         await Future.delayed(Duration(seconds: 1));
//         generatePuzzle(next: true);
//       }
//       setState(() {});
//     }
//   }
// }

// class WordFindQues {
//   String? question;
//   String? pathImage;
//   String? answer;
//   bool isDone = false;
//   bool isFull = false;
//   List<WordFindChar>? puzzles;
//   List<String>? arrayBtns;

//   WordFindQues({
//     this.pathImage,
//     this.question,
//     this.answer,
//     this.arrayBtns,
//   });

//   void setWordFindChar(List<WordFindChar> puzzles) => this.puzzles = puzzles;

//   void setIsDone() => isDone = true;

//   bool fieldCompleteCorrect() {
//     // lets declare class WordFindChar 1st
//     // check all field already got value
//     // fix color red when value not full but show red color
//     bool complete =
//         // ignore: prefer_is_empty
//         puzzles!.where((puzzle) => puzzle.currentValue == null).length == 0;

//     if (!complete) {
//       // no complete yet
//       isFull = false;
//       return complete;
//     }

//     isFull = true;
//     // if already complete, check correct or not

//     String answeredString =
//         puzzles!.map((puzzle) => puzzle.currentValue).join("");

//     // if same string, answer is correct..yeay
//     return answeredString == answer;
//   }

//   // more prefer name.. haha
//   WordFindQues clone() {
//     return WordFindQues(
//       answer: answer,
//       pathImage: pathImage,
//       question: question,
//     );
//   }

//   // lets generate sample question
// }

// // done
// class WordFindChar {
//   String? currentValue;
//   int? currentIndex;
//   String? correctValue;
//   bool hintShow;

//   WordFindChar({
//     this.hintShow = false,
//     this.correctValue,
//     this.currentIndex,
//     this.currentValue,
//   });

//   getCurrentValue() {
//     if (correctValue != null)
//       return currentValue;
//     else if (hintShow) return correctValue;
//   }

//   void clearValue() {
//     currentIndex = null;
//     currentValue = null;
//   }
// }
