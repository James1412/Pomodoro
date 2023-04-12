import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const startSeconds = 1500;
  int totalSeconds = startSeconds;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer timer; //initialize later to use

  void onTick(Timer timer) {
    // subtract 1 from totalSeconds and call the build method
    if (totalSeconds <= 0) {
      setState(() {
        totalPomodoros += 1;
        totalSeconds = startSeconds;
        isRunning = false;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds -= 1;
      });
    }
  }

  void onStartPressed() {
    // when pressed start button, for each second, run onTick
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    // when pressed pause button, cancel the timer
    // and tell the build method timer is not running
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onRestartPressed() {
    isRunning = false;
    onPausePressed();
    setState(() {
      totalSeconds = startSeconds;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    var result = duration.toString().substring(2, 7);
    return result;
  }

  void addOne() {
    setState(() {
      totalSeconds += 60;
    });
  }

  void addFive() {
    setState(() {
      totalSeconds += 300;
    });
  }

  void addTen() {
    setState(() {
      totalSeconds += 600;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(children: [
        Flexible(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Transform.translate(
              offset: const Offset(0, 80),
              child: Column(
                children: [
                  Text(
                    format(totalSeconds),
                    style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontSize: 90,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: addOne,
                          child: Text(
                            '+1',
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: addFive,
                          child: Text(
                            '+5',
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: addTen,
                          child: Text(
                            '+10',
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 130,
                  color: Theme.of(context).cardColor,
                  // if timer is running show the pause button,
                  // and when it isn't show the play button
                  onPressed: isRunning ? onPausePressed : onStartPressed,
                  icon: Icon(isRunning
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline),
                ),
                Transform.translate(
                  offset: const Offset(0, 35),
                  child: IconButton(
                    iconSize: 70,
                    color: Theme.of(context).cardColor,
                    // if timer is running show the pause button,
                    // and when it isn't show the play button
                    onPressed: onRestartPressed,
                    icon: const Icon(Icons.restart_alt_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pomodoros',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.color),
                      ),
                      Text(
                        '$totalPomodoros',
                        style: TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.color),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
