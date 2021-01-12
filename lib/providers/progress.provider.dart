class ProgressProvider {
  final Map<int, int> _progress = {
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
    6: 0,
    7: 0,
    8: 0,
    9: 0,
    10: 0,
    11: 0,
    12: 0,
    13: 0,
    14: 0,
    15: 0,
    16: 0,
    17: 0,
    18: 0,
  };

  int getProgress(int chapter) {
    return _progress[chapter];
  }

  void setProgress(int chapter, int verse) {
    _progress[chapter] = verse;
    print(_progress[chapter]);
  }
}
