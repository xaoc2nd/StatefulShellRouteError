import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';

class HomeScreen extends StatefulWidget {
  /// Creates a RootScreen
  const HomeScreen(
      {required this.label,
      required this.detailsPath,
      required this.convPath,
      Key? key})
      : super(key: key);

  /// The label
  final String label;

  /// The path to the detail page
  final String detailsPath;
  final String convPath;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.label,
              style: TextStyle(color: Colors.black),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                ),
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      GoRouter.of(context).go(widget.convPath);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Ecran accueil',
                style: Theme.of(context).textTheme.titleLarge),
            Text('Screen ${widget.label}',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () => context.go(widget.detailsPath),
              child: const Text('View details'),
            ),
            Text('Conversations - Counter: $_counter',
                style: Theme.of(context).textTheme.titleLarge),
            TextButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Text('Increment counter'),
            ),
          ],
        ),
      ),
    );
  }
}
