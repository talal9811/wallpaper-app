
import 'package:flutter/material.dart';
import 'package:josequal/components/loading.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 
  @override
  void initState() {
    onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: SizedBox(
          height: 140,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Image.asset(
                  "",
                    fit: BoxFit.fill),
              ),
              const SizedBox(
                height: 4,
              ),
              const Loading(),
              const SizedBox(
                height: 4,
              ),
              Text(
                "Loading...",
              
              )
            ],
          ),
        ),
      ),
    );
  }

  void onInit() async {
    setState(() {
  
    });

  
  }


}