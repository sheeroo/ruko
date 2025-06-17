import 'package:flutter/material.dart';

class StreamListener<T> extends StatefulWidget {
  const StreamListener({
    super.key,
    required this.stream,
    required this.child,
    required this.listener,
    this.initialData,
  });
  final Stream<T> stream;
  final Widget child;
  final void Function(T) listener;
  final Future<T> Function()? initialData;

  @override
  State<StreamListener<T>> createState() => _StreamListenerState<T>();
}

class _StreamListenerState<T> extends State<StreamListener<T>> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final initialData = await widget.initialData?.call();
      if (initialData != null) {
        widget.listener(initialData);
      }
    });
    widget.stream.listen((event) {
      widget.listener(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
