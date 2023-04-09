abstract class ToDoListException {
  final String message;

  const ToDoListException(this.message);

  @override
  String toString() {
    return message;
  }
}

class TaskNotFoundToDoListException extends ToDoListException {
  TaskNotFoundToDoListException(super.message);
}

class UnknownToDoListException extends ToDoListException {
  UnknownToDoListException(super.message);
}
