import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake/widget/food_pixel.dart';

import '../widget/blank_pixel.dart';
import '../widget/snake_pixel.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

enum snakeDirection { UP, DOWN, LEFT, RIGHT }

class _PlayScreenState extends State<PlayScreen> {
  // Variable
  List<int> snakePos = [0, 1, 2];
  int foodPos = 55;

  var currentDirection = snakeDirection.RIGHT;

  // Start game
  void _startGame() {
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        _moveSnake();
        if (gameOver()) {
          timer.cancel();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  "GAME OVER",
                  textAlign: TextAlign.center,
                ),
                content: Text(
                  'Your score is: ${snakePos.length}',
                  textAlign: TextAlign.center,
                ),
              );
            },
          );
        }
      });
    });
  }

  // Moves snake
  void _moveSnake() {
    switch (currentDirection) {
      case snakeDirection.UP:
        if (snakePos.last < 10) {
          snakePos.add(snakePos.last - 10 + 100);
        } else {
          snakePos.add(snakePos.last - 10);
        }
        break;
      case snakeDirection.DOWN:
        if (snakePos.last + 10 > 99) {
          snakePos.add(snakePos.last + 10 - 100);
        } else {
          snakePos.add(snakePos.last + 10);
        }
        break;
      case snakeDirection.LEFT:
        if (snakePos.last % 10 == 0) {
          snakePos.add(snakePos.last - 1 + 10);
        } else {
          snakePos.add(snakePos.last - 1);
        }
        break;
      case snakeDirection.RIGHT:
        if (snakePos.last % 10 == 9) {
          snakePos.add(snakePos.last + 1 - 10);
        } else {
          snakePos.add(snakePos.last + 1);
        }
        break;
    }

    if (snakePos.last == foodPos) {
      eatFood();
    } else {
      snakePos.removeAt(0);
    }
  }

  // Eat food
  void eatFood() {
    while (snakePos.contains(foodPos)) {
      foodPos = Random().nextInt(100);
    }
  }

  // Game over
  bool gameOver() {
    List<int> bodySnake = snakePos.sublist(0, snakePos.length - 1);

    if (bodySnake.contains(snakePos.last)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              // Instructions
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Instructions',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Drag to the direction where you want your snake to go!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Playing field
              SizedBox(
                height: MediaQuery.of(context).size.width,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      if (details.delta.dy > 0 &&
                          currentDirection != snakeDirection.UP) {
                        currentDirection = snakeDirection.DOWN;
                      } else if (details.delta.dy < 0 &&
                          currentDirection != snakeDirection.DOWN) {
                        currentDirection = snakeDirection.UP;
                      }
                    },
                    onHorizontalDragUpdate: (details) {
                      if (details.delta.dx > 0 &&
                          currentDirection != snakeDirection.LEFT) {
                        currentDirection = snakeDirection.RIGHT;
                      } else if (details.delta.dx < 0 &&
                          currentDirection != snakeDirection.RIGHT) {
                        currentDirection = snakeDirection.LEFT;
                      }
                    },
                    child: GridView.builder(
                      itemCount: 100,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 10,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        if (snakePos.contains(index)) {
                          return SnakePixel();
                        } else if (foodPos == index) {
                          return FoodPixel();
                        } else {
                          return BlankPixel();
                        }
                        ;
                      },
                    ),
                  ),
                ),
              ),
              // Start ganme
              Expanded(
                child: Center(
                  child: MaterialButton(
                    padding: const EdgeInsets.all(10),
                    color: Colors.green,
                    onPressed: () => _startGame(),
                    child: const Text(
                      'Start Game',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
