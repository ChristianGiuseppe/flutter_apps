import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
      body: Column(
        children: [
          SizedBox(height: 200.0, child: FrameByFrameScrolling()),
          Text('Scroll Up and Down to see the animation')
        ],
      ),
    ));
  }
}

class FrameByFrameScrolling extends StatefulWidget {
  const FrameByFrameScrolling({super.key});

  @override
  _FrameByFrameScrollingState createState() => _FrameByFrameScrollingState();
}

class _FrameByFrameScrollingState extends State<FrameByFrameScrolling> {
  int _currentIndex = 0;
  List<ui.Image> images = [];
  double totalScrollLength =
      0; // Total length over which the scroll is detected
  double currentScroll = 0; // Current scroll position

  @override
  void initState() {
    super.initState();

    load();
  }

  Future<List<ByteData>> _loadBytes() async {
    final List<ByteData> bytes = [];
    List<String> currentList = [];
    for (int i = 1; i <= 86; i++) {
      currentList.add('assets/airpods/$i.webp');
    }
    for (int i = 0; i < currentList.length; i++) {
      final _bytes = await rootBundle.load(currentList[i]);
      bytes.add(_bytes);
    }

    return bytes;
  }

  Future<List<ui.Codec>> _loadCodec(List<ByteData> bytes) async {
    final List<ui.Codec> codecs = [];
    for (ByteData byte in bytes) {
      final ui.Codec codec =
          await ui.instantiateImageCodec(byte.buffer.asUint8List());
      codecs.add(codec);
    }

    return codecs;
  }

  Future<List<ui.FrameInfo>> _loadFrameInfo(List<ui.Codec> codecs) async {
    final List<ui.FrameInfo> frameInfos = [];
    for (ui.Codec codec in codecs) {
      final frameInfo = await codec.getNextFrame();
      frameInfos.add(frameInfo);
    }

    return frameInfos;
  }

  _loadImage(List<ui.FrameInfo> frameInfos) {
    for (ui.FrameInfo frameInfo in frameInfos) {
      final image = frameInfo.image;
      setState(() {
        images.add(image);
      });
    }
  }

  load() async {
    final bytes = await _loadBytes();
    final codecs = await _loadCodec(bytes);
    final frameInfos = await _loadFrameInfo(codecs);
    _loadImage(frameInfos);
  }

  void updateImageIndex(double delta) {
    if (images.isEmpty) return;

    currentScroll += delta;
    // Ensure currentScroll is within the allowed range
    currentScroll = currentScroll.clamp(0, totalScrollLength);
    int newImageIndex =
        (images.length * (currentScroll / totalScrollLength)).floor();

    newImageIndex = math.min(newImageIndex, images.length - 1);

    if (newImageIndex != _currentIndex) {
      setState(() {
        _currentIndex = newImageIndex;
      });
    }
  }

  @override
  Future<void> dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    totalScrollLength = MediaQuery.of(context).size.height * 2;
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          // Update the image based on vertical drag
          double sensitivityFactor =
              .1; // Adjust this factor to control scroll sensitivity
          updateImageIndex(details.primaryDelta! / sensitivityFactor);
        },
        child: images.isNotEmpty
            ? Center(
                child: AspectRatio(
                  aspectRatio: (images[_currentIndex].width /
                      images[_currentIndex].height),
                  child: CustomPaint(
                    painter: ImagePainter(images[_currentIndex]),
                  ),
                ),
              )
            : Container(),
      ),
    );
  }
}

class ImagePainter extends CustomPainter {
  final ui.Image image;

  ImagePainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      rect,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
