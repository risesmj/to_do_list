import 'dart:html';

abstract class ToDoListException {
  final String message;

  const ToDoListException(this.message);
}

class UnknownToDoListException extends ToDoListException {
  UnknownToDoListException(super.message);
}
