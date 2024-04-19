// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shtodo/model/todo_model.dart';

class TodoService {
  final todoCollection = FirebaseFirestore.instance.collection('myTodo');

  // Add new task
  void addNewTask(TodoModel model) {
    todoCollection.add(model.toMap());
  }

  // Update task
  Future<void> updateTask(String? docId, bool valueUpdate) async {
    try {
      // Check if the document ID is not null before attempting to update
      if (docId != null) {
        final docSnapshot = await todoCollection.doc(docId).get();
        if (docSnapshot.exists) {
          await todoCollection.doc(docId).update({
            'isDone': valueUpdate,
          });
          print('Document with ID $docId updated successfully.');
        } else {
          print('Document with ID $docId not found.');
        }
      } else {
        print('Error: Document ID is null.');
      }
    } catch (e) {
      print('Error updating document: $e');
      // Handle the error according to your application's needs
    }
  }

  // Delete task
  Future<void> deleteTask(String? docId) async {
    try {
      await todoCollection.doc(docId).delete();
      print('Document with ID $docId deleted successfully.');
    } catch (e) {
      print('Error deleting document: $e');
      // Handle the error according to your application's needs
    }
  }
}
