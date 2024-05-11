import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';


void main() {
  runApp( MySnackBar());
}
class MySnackBar extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(body: new MyApp()),
      );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int questionIndex = 0;
  bool showScore = false;
  int score = 0;
  String? selectedAnswer;
  int iconIndex =0;
  int questionNumber =1;
  List <String> answersUser=[];

  List<Map<String, dynamic>> questionsWithAnswers = [
    {
      'question': 'What\'s your favorite color?',
      'answers':{'answers':['Red', 'Blue', 'Green', 'Black'] , 
      'icon':[
        Icons.square,
        Icons.square,
        Icons.square,
        Icons.square] ,
        'color':[Colors.red,Colors.blue,Colors.green,Colors.black]
        } ,
      'correctAnswer': 'Red',
    },
    {
      'question': 'What\'s your favorite animal?',
      'answers': {'answers':['Dog', 'Cat', 'Elephant', 'Lion'],
      'icon':[
        Icons.pets,
        Icons.cruelty_free,
        Icons.bug_report,
        Icons.emoji_nature]},
      'correctAnswer': 'Dog',
    },
    {
      'question': 'What\'s your favorite food?',
      'answers': {'answers':['Pizza', 'Burger', 'Pasta', 'Sandwich'],
      'icon':[
        Icons.local_pizza,
        Icons.lunch_dining,
        Icons.ramen_dining,
        Icons.fastfood]},
      'correctAnswer': 'Pizza',
    },
    {
      'question': 'What\'s your favorite movie?',
      'answers': {'answers':['Titanic', 'Avatar', 'Inception', 'Interstellar'],
      'icon':[
        Icons.play_arrow,
        Icons.play_circle_filled,
        Icons.videocam,
        Icons.play_circle]},
      'correctAnswer': 'Avatar',
    },
  ];
  //var questionLength =questionsWithAnswers.length;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: !showScore
          ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                child:
                Text(
                  questionsWithAnswers[questionIndex]['question'],
                  style:
                  const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24.0),
                child:
                const Text(
                  'Answer and get points!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    ),
                  ),
              ),
              const SizedBox(height: 60),
              Column(children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24.0),
                  margin: const EdgeInsets.only(bottom: 10),
                  child:Row(
                    children: [
                      Text
                        ('Step $questionNumber ',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text
                        (' of '+(questionsWithAnswers.length).toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          ),
                        ),
                    ],
                  )
                ),
                StepProgressIndicator(
                  totalSteps:questionsWithAnswers.length,
                  currentStep:questionNumber ,
                  selectedColor: Colors.green,
                  unselectedColor: const Color(0xFFFAAFA),
                  padding: 0,
                  size:2.5,
                )
              ],
              ) ,
            Container(
              color: const Color(0xfff5f5f5),
              padding: const EdgeInsets.only(top:35, left: 24.0,right: 24.0,bottom: 60),
              child: Column(
                children:
                (questionsWithAnswers[questionIndex]
                  ['answers']['answers'] as List<String>)
                  .map(
                    (answer) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedAnswer = answer;
                            answersUser.add(answer);
                          });
                        },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: answer == selectedAnswer
                                        ? Colors.green
                                        : null,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3),
                            ),
                          borderRadius: BorderRadius.circular(8),
                          ),
                        child: Row(
                          children: [
                            Icon( questionsWithAnswers[questionIndex]
                                ['answers']['icon'][(questionsWithAnswers[questionIndex]
                                ['answers']['answers'] as List<String>).indexOf(answer)],
                                          color: answer == selectedAnswer
                                              ? Colors.white
                                              : questionsWithAnswers[questionIndex]
                                ['answers']['color'] !=null ?questionsWithAnswers[questionIndex]
                                ['answers']['color'][(questionsWithAnswers[questionIndex]
                                ['answers']['answers'] as List<String>).indexOf(answer)] :null,
                                        ),
                              const SizedBox(width: 16),
                              Text(
                                answer,
                                style: TextStyle(
                                  color: answer == selectedAnswer
                                                ? Colors.white
                                                : null,
                                  fontWeight: answer == selectedAnswer
                                                ? FontWeight.bold
                                                : null,
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ).toList(),
                            
              ),
            ),
            
            Container(
              color: const Color(0xfff5f5f5),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24.0),
              width: double.infinity,
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedAnswer != null) {
                    setState(() {
                      questionNumber++;
                                  
                    });
                    if (selectedAnswer ==
                    questionsWithAnswers[questionIndex]['correctAnswer']) {
                      setState(() {
                        score++;
                      });
                    }
                    if (questionIndex <
                    questionsWithAnswers.length - 1) {
                      setState(() {
                        questionIndex++;
                        selectedAnswer=null;
                      });
                    } else {
                      setState(() {
                        showScore = true;
                      });
                    }
                    debugPrint('Index: $questionIndex');
                    } else {
                      var snackBar;
                      switch(questionIndex){
                        case 0 :   
                                snackBar = const SnackBar(content: Text('Please choose an favorite color') );
                                break;
                        case 1 :
                                snackBar = const SnackBar(content: Text('Please choose an favorite animal') );
                                break;
                        case 2 :
                                snackBar = const SnackBar(content: Text('Please choose an favorite food') );
                                break;
                        case 3 :
                                snackBar = const SnackBar(content: Text('Please choose an favorite move') );
                                break;

                                
                      }
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                               
                    }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Next'),
              ),
            ),
        ],)
        : Container(
          padding: const EdgeInsets.only(top:60),
          color: const Color(0xfff5f5f5),
          alignment: FractionalOffset.center,
          child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            const Text('Quiz Completed!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              
            )
            ),
            SizedBox(height: 20),

            CircularStepProgressIndicator(
          totalSteps: questionsWithAnswers.length,
          currentStep: score,
          width: 100,
          selectedColor: score >2 ? Colors.green : score == 2 ? Colors.yellow : Colors.red,
          child:  Align(
            alignment: Alignment.center,
            child:
            Text(' $score/${questionsWithAnswers.length}',
            style:  TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: score >2 ? Colors.green : score == 2 ? Colors.yellow : Colors.red,
            ),
          
          )
        )
           
    ),
            const SizedBox(height: 20),
            Text('Score: $score/${questionsWithAnswers.length}'),
            const SizedBox(height: 30),
            Container(child: Column(children: [
              const Row(children: [
                Padding(padding: EdgeInsets.only(left: 40.0, top:30)),
                Text("Questions",
                style:  TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
                ),
                Padding(padding: EdgeInsets.only(left: 80.0)),
                Text("Your Answer",
                style:  TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
                ),
              ],),

              Column(children: 
                (answersUser as List<String>)
                  .map(
                    (e) =>  Row(children:[
                const Padding(padding: EdgeInsets.only(left: 20.0, top:30)),
                Text(questionsWithAnswers[answersUser.indexOf(e)]['question'],
                style:  const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
                ),
                const Padding(padding: EdgeInsets.only(left: 65.0)),
                Text(e,
                style:  const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
                ),
              ], ),
                
               
              ).toList()
              ),
            ],
            )
            ),

            Container(
              padding: const EdgeInsets.only(top: 30),
              child:ElevatedButton(
              onPressed: () {
                setState(() {
                  debugPrint('$answersUser');
                  questionIndex = 0;
                  score = 0;
                  showScore = false;
                  selectedAnswer = null;
                  questionNumber=1;
                  answersUser.clear();
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  
                ),
              child: const Text('Reset'),
            ), ),
          
                    ],
          ), 
          ) 
        ),
      ),
    );
  }
}
