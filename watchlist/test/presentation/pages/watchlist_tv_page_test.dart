import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchlist/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:watchlist/presentation/pages/watchlist_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistTvBloc extends MockBloc<WatchlistTvEvent, WatchlistTvState>
    implements WatchlistTvBloc {}
class WatchlistTvStateFake extends Fake implements WatchlistTvState {}
class WatchlistTvEventFake extends Fake implements WatchlistTvEvent {}

void main() {
  late MockWatchlistTvBloc mockNotifier;

  setUpAll(() {
    mockNotifier = MockWatchlistTvBloc();
    registerFallbackValue(WatchlistTvStateFake());
    registerFallbackValue(WatchlistTvEventFake());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvBloc>(
      create: (_) => mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        when(() => mockNotifier.state).thenReturn(WatchlistTvLoading());

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

  testWidgets('Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        when(() => mockNotifier.state).thenReturn(WatchlistTvHasData(tvs));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(() => mockNotifier.state).thenReturn(const WatchlistTvError("server error"));

        final textFinder = find.byKey(const Key('error_message'));

        await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

        expect(textFinder, findsOneWidget);
      });
}
