import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health/ui/routes/home/home.cubit.dart';
import 'package:health/ui/routes/home/home.view.dart';
import 'package:health/ui/routes/result/result.cubit.dart';
import 'package:health/ui/routes/result/result.view.dart';

const routes = (
  home: 'home',
  result: 'result',
);

final routerConfigs = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      name: routes.home,
      path: '/home',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => HomeCubit(),
          child: const HomeView(),
        );
      },
    ),
    GoRoute(
      name: routes.result,
      path: '/result',
      builder: (context, state) {
        final path = state.extra.toString();
        return BlocProvider(
          create: (context) => ResultCubit(),
          child: ResultView(path: path),
        );
      },
    ),
  ],
);
