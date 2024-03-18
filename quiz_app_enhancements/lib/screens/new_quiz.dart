import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showResultsMessage = false;
  int questionIndex = 0;
  int? yourChoiceIndex;

  int result = 0;
  List chosenIndex = [];

  List correctAnswers = [
    'football',
    'winter',
    'telegram',
    'gaming',
  ];

  List chosenAnswers = [];
  List<Map<String, dynamic>> questionsWithAnswers = [
    {
      'question': 'What is the best sport ?',
      'answers': [
        {
          'title': 'basketball',
          'icon': Icons.sports_basketball,
          },
          {
            'title': 'football',
            'icon': Icons.sports_soccer,
          },
          {
            'title': 'volleyball',
            'icon': Icons.sports_volleyball,
          },
          {
            'title': 'tennis',
            'icon': Icons.sports_tennis,
          },
        ],
    },
    {
      'question': 'What is the best season of the year?',
      'answers': [
        {
          'title': 'autumn',
          'icon': Icons.cloud,
          },
          {
            'title': 'winter',
            'icon': Icons.ac_unit,
          },
          {
            'title': 'spring',
            'icon': Icons.terrain_rounded,
          },
          {
            'title': 'summer',
            'icon': Icons.sunny,
          },
        ],
    },
    {
      'question': 'What is the best social media app?',
      'answers': [
        {
          'title': 'facebook',
          'icon': Icons.facebook,
          },
          {
            'title': 'snapchat',
            'icon': Icons.snapchat,
          },
          {
            'title': 'telegram',
            'icon': Icons.telegram,
          },
          {
            'title': 'whatsapp',
            'icon': Icons.messenger,
          },
        ],
    },
    {
      'question': 'What is your favorite entertainment?',
      'answers': [
        {
          'title': 'laptop',
          'icon': Icons.laptop,
          },
          {
            'title': 'phone',
            'icon': Icons.phone_iphone,
          },
          {
            'title': 'gaming',
            'icon': Icons.sports_esports,
          },
          {
            'title': 'watching TV',
            'icon': Icons.tv,
          },
        ],
    },
 ];

  @override
  Widget build(BuildContext context) {
    // final progress = questionIndex;
    final questionWithAnswer = questionsWithAnswers[questionIndex];
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: showResultsMessage == false
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Text(questionWithAnswer['question'],
                          style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              // letterSpacing: 1
                          )),

                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      const Text('Answer and get points',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          )),
                      SizedBox(
                        height: size.height * 0.1,
                      ),

                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Step ${questionIndex + 1}',
                              style:
                                  const TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            const TextSpan(
                              text: ' of 4',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      LinearProgressIndicator(
                        value: questionIndex.toDouble() / 4,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.green,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      for (int i = 0; i < questionWithAnswer['answers'].length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                yourChoiceIndex = i;
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: i != yourChoiceIndex
                                      ? Colors.white
                                      : Colors.green,
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Icon(
                                      questionWithAnswer['answers'][i]['icon'],
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      questionWithAnswer['answers'][i]['title'],
                                      style: TextStyle(
                                          color: i != yourChoiceIndex
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              chosenAnswers.add(questionWithAnswer['answers'][yourChoiceIndex]);
                              if (yourChoiceIndex != null) {
                                if (questionIndex < questionsWithAnswers.length - 1) {
                                  questionIndex++;
                                }
                                else {
                                  for (int j = 0; j < chosenAnswers.length; j++) {
                                    if (chosenAnswers[j] == correctAnswers[j]) {
                                      result++;
                                    }
                                  }
                                  showResultsMessage = true;
                                }
                                yourChoiceIndex = null;
                              }
                              else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Choose an answer first'),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                ));
                              }
                            });
                          },
                          child: const Text('Next'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              )),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Congratulations!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.black)),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Your score is: $result/${questionsWithAnswers.length}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              questionIndex = 0;
                              showResultsMessage = false;
                              result = 0;
                              chosenAnswers.clear();
                            });
                          },
                          child: const Text(
                            'Reset quiz',
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.green,
                            textStyle: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }
}