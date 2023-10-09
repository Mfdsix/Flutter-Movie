import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}
class TvDetailStateFake extends Fake implements TvDetailState {}
class TvDetailEventFake extends Fake implements TvDetailEvent {}

void main() {
  late MockTvDetailBloc mockNotifier;

  setUp(() {
    mockNotifier = MockTvDetailBloc();
    registerFallbackValue(TvDetailStateFake());
    registerFallbackValue(TvDetailEventFake());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvDetailBloc>(
      create: (_) => mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
          (WidgetTester tester) async {
        when(() => mockNotifier.state).thenReturn(const WatchlistStatusFetched(false));

        final watchlistButtonIcon = find.byIcon(Icons.add);

        await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
          (WidgetTester tester) async {
        when(() => mockNotifier.state).thenReturn(const WatchlistStatusFetched(true));

        final watchlistButtonIcon = find.byIcon(Icons.check);

        await tester.pumpWidget(makeTestableWidget(TvDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
          (WidgetTester tester) async {
        when(() => mockNotifier.state).thenReturn(const WatchlistStatusFetched(false));

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Added to Watchlist'), findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
          (WidgetTester tester) async {
        when(() => mockNotifier.state).thenReturn(const WatchlistStatusFetched(true));

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Failed'), findsOneWidget);
      });
}