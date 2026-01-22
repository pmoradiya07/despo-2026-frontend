import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'models/embers.dart';
import 'painters/FlamePainter.dart';
import 'painters/EmberPainter.dart';
import 'utils/imageLoader.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late final Ticker _ticker;
  Duration _elapsed = Duration.zero;
  Duration _last = Duration.zero;

  bool _exiting = false;
  double _exitProgress = 0.0;

  final _rng = math.Random();
  final List<Ember> _embers = [];

  @override
  void initState() {
    super.initState();

    _initEmbers();

    _ticker = createTicker((elapsed) {
      setState(() {
        _elapsed = elapsed;

        if (_exiting) {
          _exitProgress =
              (_exitProgress + 0.016).clamp(0.0, 1.0);
        }
      });
    })..start();

    Future.delayed(const Duration(seconds: 3), _startExit);
  }

  void _initEmbers() {
    for (int i = 0; i < 50; i++) {
      _embers.add(
        Ember(
          x: _rng.nextDouble() * 12 - 6,
          y: 0,
          speed: 10 + _rng.nextDouble() * 20,
          drift: _rng.nextDouble() * 10 - 5,
          life: _rng.nextDouble(),
        ),
      );
    }
  }

  double _dt() {
    final dt =
        (_elapsed - _last).inMicroseconds / 1e6;
    _last = _elapsed;
    return dt.clamp(0.0, 0.033);
  }

  double _dYOffset() {
    final t = _elapsed.inMilliseconds / 1000.0;
    return math.sin(t * math.pi * 2 / 4) * 12 *
        (1.0 - _exitProgress);
  }

  double _dScale() {
    final t = _elapsed.inMilliseconds / 1000.0;
    return 1.0 + math.sin(t * math.pi * 2 / 6) * 0.02;
  }


  void _startExit() {
    _exiting = true;
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xFF2B0F1F),
      body: FutureBuilder<List<ui.Image>>(
        future: Future.wait([
          loadImage('assets/splash/d_body.png'),
          loadImage('assets/splash/flame.png'),
        ]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox();

          final dImage = snapshot.data![0];
          final flameImage = snapshot.data![1];

          if (_exitProgress >= 1.0) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/auth');
            });
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset('assets/splash/splashBackground.png',
                fit:BoxFit.cover,
                filterQuality: FilterQuality.none,
              ),
              Center(
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                 //Content
                  Positioned(
                    bottom: 0,
                    child: CustomPaint(
                    painter:
                    EmberPainter(_embers, _dt(), _exiting, _rng),
                    size: const Size(80, 120),
                  ),),
                  Transform.translate(
                    offset: Offset(0, _dYOffset()),
                    child: Transform.scale(
                      scale: _dScale() * (1.0 + _exitProgress * 20.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          RawImage(
                            image: dImage,
                            filterQuality: FilterQuality.none,
                          ),
                          Positioned(
                            top: -140,
                            child: CustomPaint(
                              painter: FlamePainter(
                                flameImage,
                                _elapsed,
                                _exitProgress,
                              ),
                              size: Size(
                                flameImage.width.toDouble(),
                                flameImage.height.toDouble(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]
          );
        },
      ),
    );
  }
}
