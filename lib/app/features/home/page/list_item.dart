import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:getitdone/app/features/home/controller/home_controller.dart';
import 'package:getitdone/app/models/todo_model.dart';
import 'package:intl/intl.dart';

class ListItem extends StatefulWidget {
  final TodoModel todo;
  final HomeController controller;
  const ListItem({super.key, required this.todo, required this.controller});

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  void deleteItem(BuildContext context) {
    widget.controller.deleteTodo(widget.todo.id!);
  }

  void checkItem(BuildContext context) {
    setState(() {
      widget.todo.completed = !widget.todo.completed;
    });
    widget.controller.updateTodo(
      widget.todo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Slidable(
          key: const ValueKey(0),
          endActionPane: ActionPane(
            extentRatio: 1,
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: deleteItem,
                borderRadius: BorderRadius.circular(30),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
              SlidableAction(
                onPressed: checkItem,
                borderRadius: BorderRadius.circular(30),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                icon: Icons.check,
                label: widget.todo.completed ? 'Desfazer' : 'Feito',
              ),
            ],
          ),
          child: ListTile(
            leading: widget.todo.completed
                ? const Icon(Icons.task_alt_rounded)
                : const Icon(Icons.hourglass_empty),
            title: Text(
              widget.todo.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: widget.todo.description!.isEmpty
                ? null
                : Text(
                    widget.todo.description ?? "",
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                  ),
            trailing: widget.todo.reminder != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.alarm),
                      Text(DateFormat('dd/MM/yyyy HH:mm')
                          .format(widget.todo.reminder!)),
                    ],
                  )
                : SizedBox.fromSize(),
          ),
        ),
      ),
    );
  }
}
