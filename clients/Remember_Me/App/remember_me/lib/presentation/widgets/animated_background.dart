import 'package:flutter/material.dart';
import 'package:remember_me/core/constants/app_constants.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBackground({Key? key, required this.child}) : super(key: key);

  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late Animation<double> _backgroundAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    _backgroundController = AnimationController(
      duration: AppConstants.backgroundAnimation,
      vsync: this,
    );
    
    _backgroundAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.linear,
    ));
  }

  void _startAnimations() {
    _backgroundController.repeat();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _backgroundAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepPurple.shade800,
                Colors.purple.shade600,
                Colors.pink.shade400,
                Colors.orange.shade300,
              ],
              stops: [
                0.0,
                0.3 + (_backgroundAnimation.value * 0.2),
                0.7 + (_backgroundAnimation.value * 0.2),
                1.0,
              ],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(
                  -0.5 + (_backgroundAnimation.value * 1.0),
                  -0.5 + (_backgroundAnimation.value * 0.5),
                ),
                radius: 1.5,
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}