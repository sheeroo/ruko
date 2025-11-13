import 'dart:async';

import 'package:mutex/mutex.dart';

enum PaginatorStatus {
  initial,
  loadingInitial,
  loadingMore,
  loaded,
  reachedMax,
  error,
}

abstract class Paginator<T> {
  Paginator({
    required this.pageSize,
    int currentPage = 0,
  }) : _currentPage = currentPage;

  Future<List<T>> fetch(int page);
  final StreamController<PaginatorStatus> _controller = StreamController();
  Stream<PaginatorStatus> get statusStream => _controller.stream;
  bool _hasReachedMax = false;
  int _currentPage;
  PaginatorStatus _status = PaginatorStatus.initial;
  final mutex = Mutex();
  final int pageSize;

  _changeStatus(PaginatorStatus status) {
    _status = status;
    if (_controller.isClosed) return;
    _controller.add(status);
  }

  int get currentPage => _currentPage;
  bool get hasReachedMax => _hasReachedMax;
  PaginatorStatus get status => _status;

  Future<List<T>> fetchNextPage() async {
    return await mutex.protect(
      () async {
        try {
          if (_hasReachedMax) {
            _changeStatus(PaginatorStatus.reachedMax);
            return [];
          }
          _changeStatus(
            currentPage == 0
                ? PaginatorStatus.loadingInitial
                : PaginatorStatus.loadingMore,
          );
          final items = await fetch(_currentPage);
          if (items.length < pageSize) {
            _hasReachedMax = true;
            _changeStatus(PaginatorStatus.reachedMax);
            return items;
          }
          _currentPage++;
          _changeStatus(PaginatorStatus.loaded);
          return items;
        } catch (_) {
          _changeStatus(PaginatorStatus.error);
          return [];
        }
      },
    );
  }

  void reset() {
    _currentPage = 0;
    _hasReachedMax = false;
  }

  void dispose() {
    _controller.close();
  }
}
