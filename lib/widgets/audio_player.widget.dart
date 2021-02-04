import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gita_app/config/audio_cache.config..dart';

enum PlayerState { wasPlaying, wasPaused, wasStopped }

class GitaAudioPlayer extends StatefulWidget {
  GitaAudioPlayer({Key key, this.fileName, this.width}) : super(key: key);

  final String fileName;
  final double width;

  @override
  _GitaAudioPlayerState createState() => _GitaAudioPlayerState();
}

class _GitaAudioPlayerState extends State<GitaAudioPlayer> with WidgetsBindingObserver {
  AudioPlayer _audioPlayer;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool _isplaying = false;
  PlayerState _stateBeforeInactive;
  String _cachedFilePath;
  Future<int> _loadFile;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    _audioPlayer = AudioPlayer();

    GitaAudioCache.init();

    _audioPlayer.onDurationChanged.listen((d) => setState(() => _duration = d));

    _audioPlayer.onAudioPositionChanged.listen((p) => setState(() => _position = p));

    _audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _position = Duration(seconds: 0);
        _isplaying = false;
      });
    });

    _loadFile = loadFile();
  }

  Future<int> loadFile() {
    if (_isplaying) _audioPlayer.stop();
    print("in load");
    return GitaAudioCache.loadFile(widget.fileName)
        .then((value) {
          print(value);
          _cachedFilePath = value.path;
          return _audioPlayer.setUrl(value.path, isLocal: true);
        })
        .then((value) => _audioPlayer.setReleaseMode(ReleaseMode.STOP))
        .then((value) => _audioPlayer.getDuration());
  }

  void play() {
    if (!_isplaying) {
      _audioPlayer.play(_cachedFilePath, isLocal: true);
      setState(() {
        _isplaying = true;
      });
    }
  }

  void pause() {
    _audioPlayer.pause();
    setState(() {
      _isplaying = false;
    });
  }

  void resume() {
    if (!_isplaying) {
      _audioPlayer.resume();
      setState(() {
        _isplaying = true;
      });
    }
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    _audioPlayer.seek(newDuration);
  }

  void stop() {
    _audioPlayer.stop().then((_) => setState(() {
          _isplaying = false;
          _position = Duration(seconds: 0);
        }));
  }

  void replay() {
    _audioPlayer.seek(Duration(seconds: 0));
  }

  void seekBackwardByFiveSeconds() {
    if (_position.inSeconds <= 5)
      replay();
    else
      _audioPlayer.seek(Duration(seconds: _position.inSeconds - 5));
  }

  void seekForwardByFiveSeconds() {
    if (_position.inSeconds + 5 >= _duration.inSeconds)
      stop();
    else
      _audioPlayer.seek(Duration(seconds: _position.inSeconds + 5));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        if (_isplaying)
          _stateBeforeInactive = PlayerState.wasPlaying;
        else
          _stateBeforeInactive = PlayerState.wasPaused;
        pause();
        break;
      case AppLifecycleState.resumed:
        if (_stateBeforeInactive == PlayerState.wasPlaying) resume();
        break;
      default:
    }
  }

  @override
  void didUpdateWidget(covariant GitaAudioPlayer oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if (oldWidget.fileName != widget.fileName) {
      loadFile();
    }
  }

  void onDrag(double value) {
    setState(() {
      seekToSecond(value.toInt());
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    _audioPlayer.stop();
    _audioPlayer.release();
    _audioPlayer.dispose();
    GitaAudioCache.clearCache();
  }

  @override
  Widget build(BuildContext context) {
    print("in build");
    return FutureBuilder(
      future: _loadFile,
      builder: (context, snapshot) {
        print(snapshot.data);
        print(_duration);
        if (snapshot.data == null || _duration.inSeconds == 0)
          return Center(
            child: SpinKitWave(
              color: Theme.of(context).primaryColorDark,
            ),
          );
        else
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonBar(
                  width: widget.width,
                  status: _isplaying,
                  pause: pause,
                  play: play,
                  replay: replay,
                  stop: stop,
                  seekBackwardByFiveSeconds: seekBackwardByFiveSeconds,
                  seekForwardByFiveSeconds: seekForwardByFiveSeconds,
                ),
                AudioSlider(
                  width: widget.width,
                  duration: _duration,
                  position: _position,
                  onDrag: onDrag,
                ),
              ],
            ),
          );
      },
    );
  }
}

class ButtonBar extends StatelessWidget {
  final double width;
  final bool status;
  final void Function() play;
  final void Function() pause;
  final void Function() stop;
  final void Function() replay;
  final void Function() seekBackwardByFiveSeconds;
  final void Function() seekForwardByFiveSeconds;

  ButtonBar({
    this.width,
    this.status,
    this.play,
    this.pause,
    this.stop,
    this.replay,
    this.seekBackwardByFiveSeconds,
    this.seekForwardByFiveSeconds,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            child: Icon(
              Icons.replay_rounded,
              size: 40,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            onTap: replay,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Icon(
                  Icons.replay_5_rounded,
                  size: 40,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
                onTap: seekBackwardByFiveSeconds,
              ),
              if (status)
                GestureDetector(
                  child: Icon(
                    Icons.pause_rounded,
                    size: 70,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  onTap: pause,
                )
              else
                GestureDetector(
                  child: Icon(
                    Icons.play_arrow_rounded,
                    size: 70,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  onTap: play,
                ),
              GestureDetector(
                child: Icon(
                  Icons.forward_5_rounded,
                  size: 40,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
                onTap: seekForwardByFiveSeconds,
              ),
            ],
          ),
          GestureDetector(
            child: Icon(
              Icons.stop_circle_outlined,
              size: 40,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            onTap: stop,
          ),
        ],
      ),
    );
  }
}

class AudioSlider extends StatelessWidget {
  final double width;
  final Duration position;
  final Duration duration;
  final void Function(double) onDrag;

  AudioSlider({
    this.width,
    this.position,
    this.duration,
    this.onDrag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${position.inMinutes.toString().padLeft(2, "0")}:${position.inSeconds.toString().padLeft(2, "0")}"),
          Container(
              width: width,
              child: SliderTheme(
                data: Theme.of(context).sliderTheme,
                child: Slider(
                  value: position.inSeconds.toDouble(),
                  onChanged: onDrag,
                  divisions: duration.inSeconds,
                  min: 0.0,
                  max: duration.inSeconds.toDouble(),
                  label: "${position.inMinutes.toString().padLeft(2, "0")}:${position.inSeconds.toString().padLeft(2, "0")}",
                ),
              )),
          Text("${duration.inMinutes.toString().padLeft(2, "0")}:${duration.inSeconds.toString().padLeft(2, "0")}")
        ],
      ),
    );
  }
}
