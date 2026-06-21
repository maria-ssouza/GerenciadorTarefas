import '../models/task.dart';

class TaskService {
  static final Map<String, List<Task>> _tasksByDate = {};

  static List<Task> getTasksForDate(DateTime date) {
    final dateKey = '${date.year}-${date.month}-${date.day}';
    final tasks = _tasksByDate[dateKey] ?? [];
    
    tasks.sort((a, b) {
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }
      return a.title.compareTo(b.title);
    });
    
    return tasks;
  }

  static void addTask(String title, DateTime date) {
    final dateKey = '${date.year}-${date.month}-${date.day}';
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      date: date,
    );
    
    if (!_tasksByDate.containsKey(dateKey)) {
      _tasksByDate[dateKey] = [];
    }
    
    _tasksByDate[dateKey]!.add(task);
  }

  static void removeTask(String taskId, DateTime date) {
    final dateKey = '${date.year}-${date.month}-${date.day}';
    _tasksByDate[dateKey]?.removeWhere((task) => task.id == taskId);
  }

  static void toggleTaskStatus(String taskId, DateTime date) {
    final dateKey = '${date.year}-${date.month}-${date.day}';
    final task = _tasksByDate[dateKey]?.firstWhere((task) => task.id == taskId);
    if (task != null) {
      task.isCompleted = !task.isCompleted;
    }
  }
}