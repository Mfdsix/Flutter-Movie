import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_top_rated_bloc.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvTopRatedBloc extends MockBloc<TvTopRatedEvent, TvTopRatedState>
    implements TvTopRatedBloc {}
class TvTopRatedStateFake extends Fake implements TvTopRatedState {}
class TvTopRatedEventFake extends Fake implements TvTopRatedEvent {}

void main() {
  late MockTvTopRatedBloc mockNotifier;

  setUpAll(() {
    mockNotifier = MockTvTopRatedBloc();
    registerFallbackValue(TvTopRatedStateFake());
    registerFallbackValue(TvTopRatedEventFake());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvTopRatedBloc>(
      create: (_) => mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
          (WidgetTester tester) async {
        when(() => mockNotifier.state).thenReturn(TopRatedTvsLoading());

        final progressFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressFinder, findsOneWidget);
      });

  testWidgets('Page should display when data is loaded',
          (WidgetTester tester) async {
        when(() => mockNotifier.state).thenReturn(TopRatedTvsHasData(testTvList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(() => mockNotifier.state).thenReturn(const TopRatedTvsError("server error"));

        final textFinder = find.byKey(const Key('error_message'));

        await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

        expect(textFinder, findsOneWidget);
      });
}
