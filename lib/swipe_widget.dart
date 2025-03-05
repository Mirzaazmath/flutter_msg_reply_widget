

import 'package:flutter/material.dart';

class SwipeWidget extends StatefulWidget {
  final Widget child;
  final GestureDragCancelCallback onSwipeLeft;
  const SwipeWidget({super.key, required this.child, required this.onSwipeLeft});

  @override
  State<SwipeWidget> createState() => _SwipeWidgetState();
}

class _SwipeWidgetState extends State<SwipeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  late Animation<double> _iconAnimation;
  int swipeSensitivity = 5;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.decelerate));
    _iconAnimation =
        _animationController.drive(Tween<double>(begin: 0.0, end: 0.0));
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _runAnimation(){
    _animation = Tween(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.4, 0.0),
    ).animate(
      CurvedAnimation(curve: Curves.decelerate, parent: _animationController),
    );
    //set back left/right icon animation
      _iconAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Curves.decelerate, parent: _animationController),
      );

    //Forward animation
    _animationController.forward().whenComplete(() {
      _animationController.reverse().whenComplete(() {

          //keep right icon visibility to 0.0 until onLeftSwipe triggers again
        _iconAnimation = _animationController.drive(Tween(begin: 0.0, end: 0.0));
        widget.onSwipeLeft.call();


      });
    });

    }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > swipeSensitivity) {
          _runAnimation();
        }
      },
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: ScaleTransition(
                scale: _iconAnimation,
                child: const  Icon(Icons.reply_all_outlined,size: 30,)),
          ),
          SlideTransition(
            position: _animation,
            child: widget.child,
          )
        ],
      ),
    );
  }
}
