class TodoModel {
  final String id;
  final String title;
  final bool completed;

  TodoModel({
    required this.id,
    required this.title,
    this.completed = false,
  });

}
