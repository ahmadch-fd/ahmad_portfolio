import 'package:portfolio_ahmad/features/portfolio/data/models/project_model.dart';
import 'package:portfolio_ahmad/features/portfolio/domain/entities/project.dart';
import 'package:portfolio_ahmad/features/portfolio/domain/repositories/portfolio_repository.dart';

class StaticPortfolioRepository implements PortfolioRepository {
  const StaticPortfolioRepository();

  @override
  List<Project> getFeaturedProjects() {
    return const [
      ProjectModel(
        title: 'Featured Project',
        summary:
            'Your strongest Flutter, web, or full-stack work will live here.',
        technologies: ['Flutter', 'Dart', 'Web'],
      ),
    ];
  }
}
