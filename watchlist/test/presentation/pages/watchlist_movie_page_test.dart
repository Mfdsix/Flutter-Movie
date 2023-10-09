import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchlist/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:watchlist/presentation/pages/watchlist_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistMovieBloc extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}
class WatchlistMovieStateFake extends Fake implements WatchlistMovieState {}
class WatchlistMovieEventFake extends Fake implements WatchlistMovieEvent {}

void main() {
  late MockWatchlistMovieBloc mockNotifier;

  setUpAll(() {
    mockNotifier = MockWatchlistMovieBloc();
    registerFallbackValue(WatchlistMovieStateFake());
    registerFallbackValue(WatchlistMovieEventFake());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMovieBloc>(
      create: (_) => mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        when(() => mockNotifier.state).thenReturn(WatchlistMovieLoading());

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

  testWidgets('Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        when(() => mockNotifier.state).thenReturn(WatchlistMovieHasData(tMovieList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(() => mockNotifier.state).thenReturn(const WatchlistMovieError("server error"));

        final textFinder = find.byKey(const Key('error_message'));

        await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

        expect(textFinder, findsOneWidget);
      });
}
