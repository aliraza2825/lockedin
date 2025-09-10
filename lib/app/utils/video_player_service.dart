import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:y_player/y_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'package:video_player/video_player.dart';


class VideoPlayerService extends StatefulWidget {
  final String videoUrl;
  final Function(VideoPlayerController) controller;
  final String? thumbnail;
  final int? pageIndex;
  final int? currentPageIndex;
  final bool? isPaused;
  final void Function()? videoEnded;
  const VideoPlayerService(
      {Key? key,
        required this.controller,
        required this.videoUrl,
        this.thumbnail,this.currentPageIndex,this.isPaused,this.pageIndex,this.videoEnded})
      : super(key: key);

  @override
  _VideoPlayerServiceState createState() => _VideoPlayerServiceState();
}

class _VideoPlayerServiceState extends State<VideoPlayerService> {
  late VideoPlayerController videoPlayerController;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    init();

    // videoPlayerController
  }

  init() async {
    print('_VideoPlayerServiceState.init');

    videoPlayerController =
      VideoPlayerController.asset(widget.videoUrl)
        ..initialize().then((value) {
          setState(() {
            loading = false;
          });
          videoPlayerController.play();
          videoPlayerController.setLooping(false);
          // videoPlayerController.setVolume(1);
          // widget.controller(videoPlayerController);
        });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: SizedBox(
          width: Get.width,
          child: AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: VideoPlayer(videoPlayerController))),
    );
  }

}


class VideoPlayerItem extends StatefulWidget {
  final String url;
  final String thumbnail;

  const VideoPlayerItem(
      {super.key, required this.url, required this.thumbnail});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  String? streamUrl;
  Uri? uri;
  Video? video;
  RxList<MuxedStreamInfo> qualities = <MuxedStreamInfo>[].obs;
  var qualityGroupValue = "Full HD upto 1080p".obs;
  var yt = YoutubeExplode();
  StreamManifest? manifest;
  var isInitialized = false.obs;
  late ChewieController _betterPlayerController;
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    generateVideoStreamUrl();

    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ModalRoute? route = ModalRoute.of(context);
    route?.addScopedWillPopCallback(() async {
      dispose();
      return true;
    });
  }

  @override
  void dispose() {
    // Dispose of the ChewieController and VideoPlayerController
    if (_betterPlayerController.videoPlayerController.value.isInitialized) {
      _betterPlayerController.dispose();
    }

    if (videoPlayerController.value.isInitialized) {
      videoPlayerController.dispose();
    }

    yt.close();
    // TODO: implement dispose
    // _betterPlayerController.dispose();
    // videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return  YPlayer(
    //   youtubeUrl: widget.url,
    //   placeholder: Image.network(widget.thumbnail),
    //   onStateChanged: (status) {
    //     print('Player Status: $status');
    //   },
    //   onProgressChanged: (position, duration) {
    //     print('Progress: ${position.inSeconds}/${duration.inSeconds}');
    //   },
    //   onControllerReady: (controller) {
    //     print('Controller is ready!');
    //   },
    // );
    return AspectRatio(
        aspectRatio: 16 / 9,
        child: Chewie(controller: _betterPlayerController));

    // BetterPlayer.network(
    //   streamUrl??"https://rr2---sn-2uja-3ipel.googlevideo.com/videoplayback?expire=1725040054&ei=VrHRZomUFtXDmLAPsPCmmQ4&ip=39.50.174.86&id=o-AFl_MITzB74U2_ixHK0xDaARrSHTXasIwDAt1HE-ze90&itag=18&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&mh=Iz&mm=31%2C29&mn=sn-2uja-3ipel%2Csn-4wg7zne7&ms=au%2Crdu&mv=m&mvi=2&pcm2cms=yes&pl=24&initcwndbps=388750&vprv=1&svpuc=1&mime=video%2Fmp4&rqh=1&gir=yes&clen=57240722&ratebypass=yes&dur=952.250&lmt=1712424031157673&mt=1725018064&fvip=1&c=ANDROID_TESTSUITE&txp=5319224&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cvprv%2Csvpuc%2Cmime%2Crqh%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AJfQdSswRAIgQT9dkpMGowZUPZgvb3i3QhebFhsUGfQEc_QNnWCTDnYCIC6rw09-fDL4UngJVhcPsoDNRxXVuqkXWJMMJlrPDdWl&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpcm2cms%2Cpl%2Cinitcwndbps&lsig=ABPmVW0wRAIgP_QSU5fgYqxYnDl1YWkY6J3bIz0rmR2nEBRSkFrhIoECIDFlQ79rLIJX-kUXc0iGhz2Sk9yQ1ZnyE9FkQ5w0vmVy",
    //   betterPlayerConfiguration: BetterPlayerConfiguration(
    //       autoPlay: true,
    //       autoDispose: true,
    //       controlsConfiguration:BetterPlayerControlsConfiguration(),
    //       showPlaceholderUntilPlay: true,
    //       placeholder: Image.network(widget.thumbnail),fit: BoxFit.cover),
    // )
  }

  Future generateVideoStreamUrl() async {
    videoPlayerController = VideoPlayerController.asset("assets/vid.mp4");
    _betterPlayerController = ChewieController(
      showControls: false,
      aspectRatio: 16 / 9,
      overlay: Center(
          child: CircularProgressIndicator(
        color: Colors.white,
      )),
      videoPlayerController: videoPlayerController,
      placeholder: Center(
          child: Image.network(
        widget.thumbnail,
        fit: BoxFit.fill,
      )),
      autoPlay: false,
      looping: false,
    );
    // _betterPlayerController = BetterPlayerController(BetterPlayerConfiguration());
    manifest = await yt.videos.streamsClient
        .getManifest(getYouTubeVideoId(widget.url),ytClients: [YoutubeApiClient.android]);
    // video = await yt.videos.get(getYouTubeVideoId(widget.url));
    print(manifest?.muxed);
    // print(video);
    // qualities.value = manifest!.video.toList();
    // print(qualities);
    // if (manifest!.muxed.toList().first.qualityLabel == '144p') {
    //   qualities.remove(manifest!.muxed.toList().first);
    // }
    if(manifest!.muxed.isNotEmpty){
      StreamInfo streamInfo = manifest!.muxed.first;
      // print(manifest!.muxed.last.toJson());
      uri = streamInfo.url;
      streamUrl = streamInfo.url.toString();
      print(streamUrl);
      videoPlayerController = VideoPlayerController.networkUrl(uri!);


      await videoPlayerController.initialize();
      _betterPlayerController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: false,
      );
      setState(() {});
    }


    // BetterPlayerConfiguration betterPlayerConfiguration =
    // const BetterPlayerConfiguration(
    //   autoPlay: true,
    //     aspectRatio: 16 / 9,
    //     fit: BoxFit.contain,
    //     autoDetectFullscreenDeviceOrientation: true);
    // BetterPlayerDataSource dataSource = BetterPlayerDataSource(placeholder: Image.network(widget.thumbnail,fit: BoxFit.cover,),
    //     videoFormat:BetterPlayerVideoFormat.other,videoExtension:"mp4",
    //   BetterPlayerDataSourceType.network, streamUrl!);
    // _betterPlayerController = BetterPlayerController(betterPlayerConfiguration,);
    //
    // _betterPlayerController.setupDataSource(dataSource);
  }

  getUrls(String url) async {
    manifest =
        await yt.videos.streamsClient.getManifest(getYouTubeVideoId(url));
  }

  String getYouTubeVideoId(String url) {
    List<String> data = [];
    if (url.contains("si=")) {
      data = url.split("si=");
    } else if (url.contains("vi=")) {
      data = url.split("vi=");
    } else if (url.contains("v=")) {
      data = url.split("v=");
    } else {
      data = url.split("/");
    }

    return data.last.split("&")[0];
  }
}
