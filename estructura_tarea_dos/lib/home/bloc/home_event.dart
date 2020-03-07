part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class OnAddElementEvent extends HomeEvent {
  final TodoRemainder todoReminder;

  OnAddElementEvent({@required this.todoReminder});
  @override
  List<Object> get props => [todoReminder];
}

class OnRemoveElementEvent extends HomeEvent {
  final int removedAtIndex;

  OnRemoveElementEvent({@required this.removedAtIndex});
  @override
  List<Object> get props => [removedAtIndex];
}

class OnReminderAddedEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class OnLoadRemindersEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}
