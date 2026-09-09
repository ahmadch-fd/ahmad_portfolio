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
    expect(find.text('Get In Touch'), findsOneWidget);
    expect(find.text('Download CV'), findsOneWidget);
  });
}
