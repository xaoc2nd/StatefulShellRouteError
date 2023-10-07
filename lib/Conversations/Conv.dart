import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';

class ConvScreen extends StatefulWidget {
  const ConvScreen({required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String label;

  /// The path to the detail page
  final String detailsPath;

  @override
  State<ConvScreen> createState() => _ConvScreenState();
}

class _ConvScreenState extends State<ConvScreen> {
  @override
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Conversations'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextButton(
              onPressed: () => context.go(widget.detailsPath),
              child: const Text('View details'),
            ),
            Text('Conversations - Counter: $_counter',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go('/home');
                // setState(() {
                //   _counter++;
                // });
              },
              child: const Text('Back Home'),
            ),
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
