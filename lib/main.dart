import 'package:flutter/material.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized() не нужен для веб-игры
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruit Clicker Game',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Устанавливаем GameScreen как домашнюю страницу
      home: const GameScreen(),
    );
  }
}

// --- Класс Игрового Экрана (StatefulWidget) ---

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _score = 0; // Текущий счет
  String _currentFruit = '🍎'; // Текущий фрукт (можно менять)
  double _fruitSize = 100.0; // Размер фрукта для анимации

  // Функция, вызываемая при нажатии на фрукт
  void _handleFruitTap() {
    setState(() {
      _score++; // Увеличиваем счет
      // Создаем простой эффект анимации
      _fruitSize = 120.0; // Увеличиваем размер
    });
    // Через короткое время возвращаем размер
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _fruitSize = 100.0; // Возвращаем исходный размер
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruit Clicker', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 1. Отображение счета
            const Text(
              'Счет:',
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
            Text(
              '$_score',
              style: const TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.w900,
                  color: Colors.green),
            ),
            const SizedBox(height: 50),

            // 2. Кликабельный фрукт с анимацией
            GestureDetector(
              onTap: _handleFruitTap, // Привязываем функцию нажатия
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100), // Длительность анимации
                width: _fruitSize,
                height: _fruitSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    _currentFruit,
                    style: TextStyle(fontSize: _fruitSize * 0.8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            // 3. Инструкция
            const Text(
              'Нажмите на фрукт, чтобы заработать очки!',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}