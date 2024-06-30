import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health/ui/routes/result/result.cubit.dart';
import 'package:health/ui/routes/result/result.state.dart';

class ResultView extends StatefulWidget {
  const ResultView({super.key, required this.path});

  final String path;

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  ResultCubit get cubit => BlocProvider.of(context);

  @override
  void initState() {
    super.initState();
    cubit.load(widget.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnose Result'),
      ),
      body: BlocBuilder<ResultCubit, ResultState>(
        builder: (context, state) {
          if (state.status == 1) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == -1) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_rounded,
                      size: 64,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error!',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.error,
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        cubit.load(widget.path);
                      },
                      child: const Text('Reload'),
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.file(
                  File(widget.path),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              if (state.result?.title != null) ...[
                Text(
                  state.result!.title!,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 8),
              ],
              if (state.result?.content != null)
                Text(
                  state.result!.content!,
                  textAlign: TextAlign.justify,
                ),
            ],
          );
        },
      ),
    );
  }
}
