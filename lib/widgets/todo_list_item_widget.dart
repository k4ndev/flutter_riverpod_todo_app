import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_app/models/todo_model.dart';
import 'package:flutter_riverpod_app/providers/all_provider.dart';

class TodoListItemWidget extends ConsumerStatefulWidget {
  const TodoListItemWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<TodoListItemWidget> createState() => _TodoListItemWidgetState();
}

class _TodoListItemWidgetState extends ConsumerState<TodoListItemWidget> {
  late FocusNode _textFocusNode;
  late TextEditingController _textController;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _textFocusNode = FocusNode();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textFocusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTodo = ref.watch(currentTodoProvider);
    return Focus(
      onFocusChange: (isFocus) {
        if (!isFocus) {
          setState((() => _hasFocus = false));
          ref
              .read(toDoListProvider.notifier)
              .edit(id: currentTodo.id, title: _textController.text);
        }
      },
      child: ListTile(
        onTap: () {
          setState(() {
            _hasFocus = true;
            _textFocusNode.requestFocus();
            _textController.text = currentTodo.title;
          });
        },
        leading: Checkbox(
            value: currentTodo.completed,
            onChanged: (value) {
              ref.read(toDoListProvider.notifier).toggle(currentTodo.id);
            }),
        title: _hasFocus
            ? TextField(
                controller: _textController,
                focusNode: _textFocusNode,
              )
            : Text(currentTodo.title),
      ),
    );
  }
}
