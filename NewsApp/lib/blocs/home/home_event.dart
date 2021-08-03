abstract class HomeEvent {
  HomeEvent([List event = const []]);
}

class HomeDataEvent extends HomeEvent {
  HomeDataEvent() : super([]);
}
