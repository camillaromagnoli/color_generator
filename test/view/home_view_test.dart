import 'package:color_generator/view/home_view.dart';
import 'package:color_generator/view_model/color_generator_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/colors_mock.dart';
import '../mocks/view_model_mock.dart';

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  addTearDown(container.dispose);

  return container;
}

void main() {
  late ProviderContainer container;

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();

    container = ProviderContainer(
      overrides: [
        colorGeneratorViewModelProvider.overrideWith(
          () => ColorGeneratorViewModelMock(lightColorMock),
        ),
      ],
    );
  });

  group('HomeView tests...', () {
    testWidgets('HomeView displays a light background with dark text', (
      tester,
    ) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(home: HomeView()),
        ),
      );

      await tester.pumpAndSettle();

      final scaffold = find.byWidgetPredicate(
        (widget) =>
            widget is Scaffold && widget.backgroundColor == lightColorMock,
      );
      expect(scaffold, findsOneWidget);

      final text = find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data == 'Hello there!' &&
            widget.style?.color == Colors.black,
      );
      expect(text, findsOneWidget);
    });

    testWidgets('HomeView displays a dark background with light text', (
      tester,
    ) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: ProviderContainer(
            overrides: [
              colorGeneratorViewModelProvider.overrideWith(
                () => ColorGeneratorViewModelMock(darkColorMock),
              ),
            ],
          ),
          child: const MaterialApp(home: HomeView()),
        ),
      );

      await tester.pumpAndSettle();

      final scaffold = find.byWidgetPredicate(
        (widget) =>
            widget is Scaffold && widget.backgroundColor == darkColorMock,
      );
      expect(scaffold, findsOneWidget);

      final text = find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data == 'Hello there!' &&
            widget.style?.color == Colors.white,
      );
      expect(text, findsOneWidget);
    });

    testWidgets('HomeView displays random color on tap Scaffold', (
      tester,
    ) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(home: HomeView()),
        ),
      );
      await tester.pumpAndSettle();

      final scaffoldTap = find.byType(GestureDetector);

      await tester.tap(scaffoldTap);

      await tester.pumpAndSettle();

      expect(
        container.read(colorGeneratorViewModelProvider) != lightColorMock,
        true,
      );
    });
  });
}
