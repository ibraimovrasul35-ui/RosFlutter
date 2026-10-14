import 'package:flutter/material.dart';

import 'home_screen.dart';

/// Приветственные слайды на PageView.
class OnboardingScreen extends StatefulWidget {
  static const routeName = '/';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  static const _slides = [
    (image: 'assets/images/carbonara.jpg', title: 'Готовьте с удовольствием', text: 'Простые и понятные рецепты на каждый день.'),
    (image: 'assets/images/greek_salad.jpg', title: 'Выбирайте по категориям', text: 'Завтраки, супы, салаты, основные блюда и десерты.'),
    (image: 'assets/images/brownies.jpg', title: 'Сохраняйте любимое', text: 'Добавляйте рецепты в избранное одним нажатием.'),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_page == _slides.length - 1) {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLast = _page == _slides.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, HomeScreen.routeName),
                child: const Text('Пропустить'),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (context, i) {
                  final slide = _slides[i];
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 240,
                          height: 240,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: AssetImage(slide.image), fit: BoxFit.cover),
                            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))],
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(slide.title, style: theme.textTheme.headlineMedium, textAlign: TextAlign.center),
                        const SizedBox(height: 12),
                        Text(slide.text, style: theme.textTheme.bodyLarge, textAlign: TextAlign.center),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_slides.length, (i) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: i == _page ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: i == _page ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: _next,
                  child: Text(isLast ? 'Начать' : 'Далее', style: const TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
