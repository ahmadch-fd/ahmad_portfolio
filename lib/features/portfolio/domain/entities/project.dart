class Project {
  const Project({
    required this.title,
    required this.summary,
    required this.technologies,
    this.link,
  });

  final String title;
  final String summary;
  final List<String> technologies;
  final Uri? link;
}
