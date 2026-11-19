import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modul_6/models/todo.dart';

class FirestoreService {
  final CollectionReference _todosCollection = FirebaseFirestore.instance
      .collection('todos');

  // create
  Future<void> addTodo(String taskName) async {
    final newTodo = Todo(id: '', task: taskName, isDone: false);
    await _todosCollection.add(newTodo.toMap());
  }

  // read
  Stream<List<Todo>> getTodos() {
    return _todosCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Todo.fromFirestore(doc)).toList(),
        );
  }

  //update
  Future<void> updateTodoStatus(String id, bool currentStatus) async {
    await _todosCollection.doc(id).update({'idDone': !currentStatus});
  }

  // delete
  Future<void> deleteTodo(String id) async {
    await _todosCollection.doc(id).delete();
  }
}
