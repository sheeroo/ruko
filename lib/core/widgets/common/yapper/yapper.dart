class Yapper {
  Yapper();
  final counter = Counter();

  bool oneBeforeLast() {
    return counter.counter == yaps.length - 2;
  }

  bool hasNextYap() {
    return counter.counter < yaps.length - 1;
  }

  String get nextYap {
    return yaps[counter.next % yaps.length];
  }

  List<String> get yaps => const [
        "life as seen through your eyes",
        "this is a secret message",
        "if you have a good idea you have to write it down",
        "please write it down please write it down",
        "a random thought crossed my mind oooh no IT IS THE CRUSHING FEAR OF DEATH",
        "[screaming] i am okay",
        "[suddenly]",
        "a leaf falls from a tree",
        "gravity gently pulls it towards the ground",
        "the wind guides it towards the nearby stream",
        "[suddenly]",
        "oh hi there :3",
        "can you help me with something",
        "do you have any idea what this thing is? i found it in the woods. i think it's a hat",
      ];
}

class Counter {
  Counter();
  int _counter = 0;
  int get counter {
    return _counter;
  }

  int get next {
    _counter = _counter + 1;
    return _counter;
  }
}
