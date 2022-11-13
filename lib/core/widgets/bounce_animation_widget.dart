import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BounceAnimationWidget extends HookWidget {
  const BounceAnimationWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  Future doAnimation(AnimationController controller) async {
    await Future.delayed(const Duration(milliseconds: 100));
    await controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final AnimationController controller = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );
    final scale = Tween<double>(begin: 0.8, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack));
    final fade = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    useEffect(() {
      doAnimation(controller);
      return null;
    }, []);
    return FadeTransition(
      opacity: fade,
      child: ScaleTransition(scale: scale, child: child),
    );
  }
}
