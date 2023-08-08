import 'package:flutter/material.dart';
import 'package:tekflat_design/tekflat_design.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TekSkeleton(
              active: true,
              direction: TekSkeletonDirection.ltr,
              title: const TekSkeletonTitleProps(
                width: 200,
              ),
              avatar: TekSkeletonAvatarProps(
                shape: TekSkeletonShape.circle,
                size: TekSpacings().p32 * 1.4,
              ),
              paragraph: TekSkeletonParagraphProps(
                rows: 6,
                widths: [500, 600, 400, 450, 500, 500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
