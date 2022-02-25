import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetherapp/cubit/wehter_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController conteroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: BlocProvider(
        create: (context) => WehterCubit(),
        child: BlocBuilder<WehterCubit, WehterState>(
          builder: (context, state) {
            if (state is WehterInitial) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: TextFormField(
                        controller: conteroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'City',
                        ),
                        maxLength: 20,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<WehterCubit>(context)
                              .getWeather(conteroller.text);
                        },
                        child: Text("Send data"))
                  ],
                ),
              );
            } else if (state is WehterLoaded) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Monday',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '6:35am',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      state.model.name!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // Image.network(
                    //   'https://e7.pngegg.com/pngimages/3/772/png-clipart-weather-forecasting-rain-and-snow-mixed-cloud-weather-icon-cloud-heart-thumbnail.png',
                    //   height: 200,
                    // ),
                    Icon(
                      Icons.wb_sunny,
                      size: 170,
                      color: Colors.yellow[300],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "${state.model.main!.temp!.toInt() - 273}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Monday',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Divider(
                        thickness: 3,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is WehterError) {
              return Center(
                child: Text("Server error"),
              );
            } else if (state is WehterLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: Text("Nothing"),
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     print("send buttn");
      //     BlocProvider.of<WehterCubit>(context).getWeather(conteroller.text);
      //   },
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.download),
      // ),
    );
  }
}
