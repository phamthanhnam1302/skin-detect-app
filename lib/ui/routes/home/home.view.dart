import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health/ui/routes/home/home.cubit.dart';
import 'package:health/ui/routes/home/home.state.dart';
import 'package:health/ui/routes/routes.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeCubit get cubit => BlocProvider.of(context);

  @override
  void initState() {
    super.initState();
    cubit.initialize();
  }

  void onFile(String path) {
    cubit.pauseCam();
    context
        .pushNamed(
          routes.result,
          extra: path,
        )
        .whenComplete(cubit.resumeCam,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.status == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == PermissionStatus.denied) {
            return Center(
              child: TextButton(
                onPressed: cubit.requestPermission,
                child: const Text('Grant permission'),
              ),
            );
          }
          if (state.status == PermissionStatus.permanentlyDenied) {
            return Center(
              child: TextButton(
                onPressed: cubit.openSettings,
                child: const Text('Open settings to grant permission'),
              ),
            );
          }
          return buildCamera(state);
        },
      ),
    );
  }

  Widget buildCamera(HomeState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CameraPreview(cubit.camController),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              cubit.capture().then(onFile);
            },
            child: const Text('Diagnose'),
          ),
          const SizedBox(height: 8),
          Text(
            'Or',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              cubit.pickImage().then((value) {
                if (value != null) {
                  onFile(value);
                }
              });
            },
            child: const Text('Select image from gallery'),
          ),
        ],
      ),
    );
  }
}
