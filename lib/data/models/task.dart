class Task {
  final String id;
  final String title;
  final String desc;
  final bool isUploaded;

  Task({
    required this.id,
    required this.title,
    required this.desc,
    this.isUploaded = false,
  });
}
