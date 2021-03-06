// import 'package:video_player/video_player.dart';
// import 'package:flutter/material.dart';

// class VideoApp extends StatefulWidget {
//   final String link;
//   const VideoApp(this.link);
//   @override
//   _VideoAppState createState() => _VideoAppState();
// }

// class _VideoAppState extends State<VideoApp> {
//   String linkMaker() {
//     String newLink = widget.link;
//     newLink = newLink.replaceFirst('https://drive.google.com/file/d/',
//         'https://www.googleapis.com/drive/v3/files/');
//     newLink = newLink.replaceFirst('/view?usp=sharing',
//         '?alt=media&key=AIzaSyAHZvpRfSSLv8d-PAStwwTzmig4VGx3a1o');
//     return newLink;
//   }

//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     String newLink = linkMaker();
//     super.initState();
//     _controller = VideoPlayerController.network(newLink)
//       ..initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         setState(() {});
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Video Demo',
//       home: Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(
//           child: _controller.value.isInitialized
//               ? AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 )
//               : Container(),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             setState(() {
//               _controller.value.isPlaying
//                   ? _controller.pause()
//                   : _controller.play();
//             });
//           },
//           child: Icon(
//             _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

// ignore: camel_case_types
class player extends StatefulWidget {
  final String link;
  const player({Key? key, required this.link}) : super(key: key);

  @override
  _playerState createState() => _playerState();
}

// ignore: camel_case_types
class _playerState extends State<player> {
  String linkMaker() {
    String newLink = widget.link;
    newLink = newLink.replaceFirst('https://drive.google.com/file/d/',
        'https://www.googleapis.com/drive/v3/files/');
    newLink = newLink.replaceFirst('/view?usp=sharing',
        '?alt=media&key=AIzaSyAHZvpRfSSLv8d-PAStwwTzmig4VGx3a1o');
    return newLink;
  }

  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    String newLink = linkMaker();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(newLink),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlickVideoPlayer(flickManager: flickManager);
  }
}
