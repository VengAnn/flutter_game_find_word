import 'package:flutter/material.dart';
import 'package:flutter_game_wordfind_basic/models/word_find_class.dart';
import 'package:flutter_game_wordfind_basic/widgets/word_find_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<WordFindQues> listQuestions;
  late int indexQues = 0;
  late GlobalKey<WordFindWidgetState> globalKey;

  @override
  void initState() {
    super.initState();
    globalKey = GlobalKey();
    listQuestions = [
      WordFindQues(
        question: "What is the name of this game?",
        answer: "mario",
        pathImage:
            "https://images.pexels.com/photos/163077/mario-yoschi-figures-funny-163077.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      ),
      WordFindQues(
        question: "What is this animal?",
        answer: "cat",
        pathImage:
            "https://images.pexels.com/photos/617278/pexels-photo-617278.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      ),
      WordFindQues(
        question: "What is this animal's name?",
        answer: "wolf",
        pathImage:
            "https://as1.ftcdn.net/v2/jpg/02/48/64/04/1000_F_248640483_5KAZi0GqcWrBu6GOhFEAxk1quNEuOzHJ.jpg",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.green,
          child: Column(
            children: [
              Expanded(
                child: WordFindWidget(
                  listQuestions: listQuestions,
                  key: globalKey,
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    globalKey.currentState!.generatePuzzle(
                      loop: listQuestions.map((ques) => ques.clone()).toList(),
                    );
                  },
                  child: const Text("Reload"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
