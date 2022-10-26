import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  const MyAppBar({super.key, this.actionsAppBar, this.title});
  final String? title;
  final List<Widget>? actionsAppBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? ""),
      actions: actionsAppBar ?? [],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 191, 255),
              Color.fromARGB(255, 102, 241, 255),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
