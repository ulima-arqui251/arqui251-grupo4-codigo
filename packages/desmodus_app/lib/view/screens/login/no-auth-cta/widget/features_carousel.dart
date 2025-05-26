import 'dart:async';
import 'package:flutter/material.dart';
import 'package:desmodus_app/utils/padding_extensions.dart';

class FeaturesCarouselWidget extends StatefulWidget {
  const FeaturesCarouselWidget({super.key});

  @override
  State<FeaturesCarouselWidget> createState() => _FeaturesCarouselWidgetState();
}

class _FeaturesCarouselWidgetState extends State<FeaturesCarouselWidget> {
  final _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  final List<Widget> _pages = [
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.search, size: 150),
        10.pv,
        Text(
          'Explora nuestras funciones avanzadas',
          textAlign: TextAlign.center,
        ),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.security, size: 150),
        10.pv,
        Text('Tu seguridad es nuestra prioridad', textAlign: TextAlign.center),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.star, size: 150),
        10.pv,
        Text(
          'Accede a características exclusivas',
          textAlign: TextAlign.center,
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();

    // Cada 5 segundos, cambia a la siguiente página
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % _pages.length;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(controller: _pageController, children: _pages);
  }
}
