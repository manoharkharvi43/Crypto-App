import 'dart:async';

class BottomTabIndexStream {
  final StreamController<int> _bottomTabIndexSC = StreamController.broadcast();
  Sink<int> get bottomTabIndexSink => _bottomTabIndexSC.sink;
  Stream<int> get bottomTabIndexStream => _bottomTabIndexSC.stream;

  setCurrentTabIndexToStream(int data) {
    bottomTabIndexSink.add(data);
  }

  Stream<int> get outputbottomTabIndex =>
      bottomTabIndexStream.map((val) => val);
}
