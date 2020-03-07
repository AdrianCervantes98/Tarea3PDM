part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitialState extends HomeState {
  @override
  List<Object> get props => [];
}

class LoadedRemindersState extends HomeState {
  final List<TodoRemainder> todosList;

  LoadedRemindersState({@required this.todosList});
  @override
  List<Object> get props => [todosList];
}

class NewReminderState extends HomeState {
  final TodoRemainder todo;

  NewReminderState({@required this.todo});
  @override
  List<Object> get props => [todo];
}

class AwaitingEventsState extends HomeState {
  @override
  List<Object> get props => [];
}

class NoRemindersState extends HomeState {
  @override
  List<Object> get props => [];
}
