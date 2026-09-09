import 'package:portfolio_ahmad/features/portfolio/domain/entities/project.dart';

abstract interface class PortfolioRepository {
  List<Project> getFeaturedProjects();
}
