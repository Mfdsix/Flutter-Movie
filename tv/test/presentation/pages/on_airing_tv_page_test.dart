import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_on_airing_bloc.dart';
import 'package:tv/presentation/pages/on_airing_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvOnAiringBloc extends MockBloc<TvOnAiringEvent, TvOnAiringState>
    implements TvOnAiringBloc {}
class TvOnAiringStateFake extends Fake implements TvOnAiringState {}
class TvOnAiringEventFake extends Fake implements TvOnAiringEvent {}

void main() {
  late MockTvOnAiringBloc mockNotifier;

  setUpAll(() {
    mockNotifier = MockTvOnAiringBloc();
    registerFallbackValue(TvOnAiringStateFake());
    registerFallbackValue(TvOnAiringEventFake());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvOnAiringBloc>(
      create: (_) => mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        when(() => mockNotifier.state).thenReturn(OnAiringTvLoading());

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(makeTestableWidget(const OnAiringTvPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

  testWidgets('Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        when(() => mockNotifier.state).thenReturn(OnAiringTvHasData(testTvList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(makeTestableWidget(const OnAiringTvPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(() => mockNotifier.state).thenReturn(const OnAiringTvError("server error"));

        final textFinder = find.byKey(const Key('error_message'));

        await tester.pumpWidget(makeTestableWidget(const OnAiringTvPage()));

        expect(textFinder, findsOneWidget);
      });
}
