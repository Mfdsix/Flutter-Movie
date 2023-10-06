import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv/tv_on_airing_bloc.dart';
import 'package:ditonton/presentation/provider/tv/on_airing_tvs_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class OnAiringTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv/on-airing';

  const OnAiringTvPage({super.key});

  @override
  _OnAiringTvPageState createState() => _OnAiringTvPageState();
}

class _OnAiringTvPageState extends State<OnAiringTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TvOnAiringBloc>().add(const OnFetchOnAiringTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On Airing Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvOnAiringBloc, TvOnAiringState>(
          builder: (context, state) {
            if (state is OnAiringTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OnAiringTvHasData) {
              final result = state.result;

              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvCard(tv);
                },
                itemCount: result.length,
              );
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text("Failed"),
              );
            }
          },
        ),
      ),
    );
  }
}
