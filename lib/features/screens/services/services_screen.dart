import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novsu_mobile/features/screens/services/bloc/services_bloc.dart';



class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesBloc, ServicesState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Services'), //TODO i18n
          actions: [
            GestureDetector(
              onTap: () => BlocProvider.of<ServicesBloc>(context).add(LogOutEvent()),
              child: const Icon(
                Icons.sensor_door_outlined,
              ),
            )
          ],
        ),
      ),
    );  }
}
