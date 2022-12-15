import 'dart:math';

import 'package:flutter/material.dart';

List<IconData> someIcons = [
  Icons.add_alarm,
  Icons.cabin,
  Icons.menu,
  Icons.settings,
  Icons.account_circle_outlined
];

class IconBox extends StatefulWidget {
  const IconBox({super.key});

  @override
  State<IconBox> createState() => _IconBoxState();
}

class _IconBoxState extends State<IconBox> {
  bool show = false;
  bool expand = false;

  Widget getAction() {
    return _IconBoxItem(
      show: show,
      icon: Icon(
        getRandomIcon(),
        color: Colors.white,
        size: 32,
      ),
      color: Colors.blue.withOpacity(0.9),
      onTap: () {},
    );
  }

  IconData getRandomIcon() {
    return someIcons[Random().nextInt(someIcons.length)];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        if (!expand) {
          expand = true;
          Future.delayed(const Duration(milliseconds: 200),
              () => setState(() => show = true));
        } else {
          show = false;
          Future.delayed(const Duration(milliseconds: 400),
              () => setState(() => expand = false));
        }
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: expand ? 400 : 200,
        height: expand ? 400 : 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(expand ? 40 : 20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 20,
              offset: const Offset(-20, -20),
            ),
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 20,
              offset: const Offset(20, 20),
            ),
          ],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          child: expand
              ? Padding(
                  key: const ValueKey(1),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          getAction(),
                          const SizedBox(width: 20),
                          getAction(),
                          const SizedBox(width: 20),
                          getAction(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          getAction(),
                          const SizedBox(width: 20),
                          getAction(),
                          const SizedBox(width: 20),
                          getAction(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          getAction(),
                          const SizedBox(width: 20),
                          getAction(),
                          const SizedBox(width: 20),
                          getAction(),
                        ],
                      ),
                    ],
                  ),
                )
              : Text(
                  "See Available Actions",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                  key: ValueKey(1),
                ),
        ),
      ),
    );
  }
}

class _IconBoxItem extends StatefulWidget {
  final bool show;
  final Icon icon;
  final Color color;
  VoidCallback? onTap;

  _IconBoxItem(
      {super.key,
      required this.show,
      required this.icon,
      required this.color,
      this.onTap});

  @override
  State<_IconBoxItem> createState() => _IconBoxItemState();
}

class _IconBoxItemState extends State<_IconBoxItem> {
  bool hover = false;
  bool tap = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap?.call();
        setState(() => tap = true);
      },
      onTapUp: (e) => setState(() => tap = false),
      child: MouseRegion(
        onEnter: (e) => setState(() => hover = true),
        onExit: (e) => setState(() {
          hover = false;
          tap = false;
        }),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: widget.show
              ? AnimatedContainer(
                  key: const ValueKey(1),
                  duration: const Duration(milliseconds: 100),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [widget.color, hover ? Colors.red : widget.color], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.circular(hover ? 0 : 20),
                    border: hover
                        ? Border.all(
                            color: tap ? Colors.blue.shade600 : Colors.white,
                            width: tap ? 10 : 6)
                        : null,
                  ),
                  child: Center(child: widget.icon),
                )
              : const SizedBox(key: ValueKey(2)),
          transitionBuilder: (child, animation) =>
              RotationTransition(turns: animation, child: ScaleTransition(scale: animation, child: child)),
        ),
      ),
    );
  }
}
