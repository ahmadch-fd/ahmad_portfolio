import 'package:portfolio_ahmad/features/portfolio/domain/entities/project.dart';

class ProjectModel extends Project {
  const ProjectModel({
    required super.title,
    required super.summary,
    required super.technologies,
    super.link,
  });
}
