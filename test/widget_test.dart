import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_ahmad/app/portfolio_app.dart';

void main() {
  testWidgets('renders portfolio shell', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());

    await tester.pump(const Duration(milliseconds: 3000));
    await tester.pump(const Duration(milliseconds: 800));

    expect(find.text('EXPERIENCE WITH'), findsOneWidget);
    expect(find.text('Flutter Mobile Application Developer'), findsOneWidget);
    expect(
      find.textContaining('Islamia University of Bahawalpur'),
      findsOneWidget,
    );

    await tester.ensureVisible(find.text('Get In Touch'));
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text('Get In Touch'));
    await tester.pump(const Duration(milliseconds: 900));

    expect(find.text('ahmadbilal01142@gmail.com'), findsOneWidget);

    await tester.ensureVisible(find.text('EXPERIENCE WITH').first);
    await tester.pump(const Duration(milliseconds: 500));

    await tester.ensureVisible(find.text('EXPERIENCE').first);
    await tester.pump(const Duration(milliseconds: 800));

    expect(find.text('EXPERIENCE'), findsOneWidget);
    expect(find.textContaining('Code Thinker'), findsOneWidget);
    expect(find.textContaining('Innovista'), findsOneWidget);
    expect(find.text('PROJECTS'), findsOneWidget);
    expect(find.text('TaskFlow'), findsOneWidget);

    await tester.ensureVisible(find.text('TaskFlow').first);
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text('TaskFlow').first);
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Project Details'), findsOneWidget);
    expect(
      find.text('Daily task planning with priority states'),
      findsOneWidget,
    );

    await tester.binding.handlePopRoute();
    await tester.pump(const Duration(milliseconds: 800));
    expect(find.text('Project Details'), findsNothing);

    expect(find.text('WHY CHOOSE ME'), findsOneWidget);
    expect(find.text('Startup Speed'), findsOneWidget);
    expect(find.text('How I Work'), findsOneWidget);
    expect(find.text('Discovery'), findsOneWidget);
    expect(find.text('Ahmad Bilal'), findsWidgets);
    expect(find.text('+92 3087154021'), findsOneWidget);
    expect(find.text('ahmadbilal01142@gmail.com'), findsOneWidget);
    expect(find.text('github.com/ahmadch-fd'), findsWidgets);
    expect(find.text('Get In Touch'), findsOneWidget);
    expect(find.text('Download CV'), findsOneWidget);
  });
}
