import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/page_manager.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final ScrollController _controller = ScrollController();
  late final PageManager _pageManager;

  @override
  void initState() {
    super.initState();
    _pageManager = PageManager();
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  String getSongTitle(int songIndex) {
    switch (songIndex) {
      case 0:
        return 'SIP-Tiny';
      case 1:
        return 'Savings Equation';
      case 2:
        return 'Pay yourself first';
      case 3:
        return 'Identify your financial goals';
      case 4:
        return 'Priorities yourself financial goals';
    }
    return '';
  }

  String getSongArtist(int songIndex) {
    switch (songIndex) {
      case 0:
        return 'Mutual Fund';
      case 1:
        return 'Mutual Fund';
      case 2:
        return 'Mutual Fund';
      case 3:
        return 'Mutual Fund';
      case 4:
        return 'Mutual Fund';
    }
    return '';
  }

  String getSongDuration(int idx) {
    late Duration duration;
    switch (idx) {
      case 0:
        duration = const Duration(minutes: 6, seconds: 12);
        break;
      case 1:
        duration = const Duration(minutes: 7, seconds: 5);
        break;
      case 2:
        duration = const Duration(minutes: 5, seconds: 44);
        break;
      case 3:
        duration = const Duration(minutes: 5, seconds: 2);
        break;
      case 4:
        duration = const Duration(minutes: 6, seconds: 12);
    }
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  color: Colors.white,
                  margin: const EdgeInsets.only(top: 24),
                  child: Row(children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 25,
                      ),
                      onPressed: () {},
                    ),
                    const Spacer(),
                    InkWell(
                        onTap: () {},
                        child: Image.asset(
                          'assets/share_icon.png',
                          height: 25,
                          width: 25,
                        )),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bookmark_border_rounded,
                        size: 27,
                        color: Colors.black,
                      ),
                    ),
                  ]),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.height * 0.3,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 23),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50)),
                  ),
                  child: Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40)),
                        image: DecorationImage(
                          image: AssetImage('assets/album_art.png'),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 32,
                  width: 98,
                  margin: const EdgeInsets.only(bottom: 23),
                  decoration: BoxDecoration(
                      color: const Color(0xffA9CCFF),
                      borderRadius: const BorderRadius.all(Radius.circular(21)),
                      border: Border.all(color: const Color(0xff000AFF))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/hand_pointer.png'),
                        const SizedBox(
                          width: 7,
                        ),
                        const Text(
                          'Pointers',
                          style: TextStyle(
                            color: Color(0xff000AFF),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ValueListenableBuilder<String>(
                            valueListenable:
                                _pageManager.currentSongTitleNotifier,
                            builder: (_, value, __) {
                              return Text(
                                value,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            getSongArtist(
                                _pageManager.currentSongIndex() as int),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            'Language',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            'English',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset('assets/music_symbol.png'),
                  ),
                ),
                ValueListenableBuilder<ProgressBarState>(
                  valueListenable: _pageManager.progressNotifier,
                  builder: (_, value, __) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ProgressBar(
                        progress: value.current,
                        buffered: value.buffered,
                        total: value.total,
                        onSeek: _pageManager.seek,
                        barHeight: 2.2,
                        thumbColor: const Color(0xff00FF92),
                        progressBarColor: const Color(0xff1CC57D),
                        baseBarColor: const Color(0xffCCCCCC),
                        bufferedBarColor: Colors.grey,
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ValueListenableBuilder<int>(
                          valueListenable:
                              _pageManager.currentSongIndexNotifier,
                          builder: (_, value, __) {
                            return IconButton(
                              onPressed: () {
                                _pageManager.previous();
                              },
                              icon: Icon(
                                Icons.skip_previous,
                                color: value == 0 ? Colors.grey : Colors.black,
                              ),
                            );
                          }),
                      IconButton(
                        onPressed: () {
                          _pageManager.seekBackward();
                        },
                        icon: Image.asset(
                          'assets/seek_backward.png',
                        ),
                      ),
                      ValueListenableBuilder<ButtonState>(
                        valueListenable: _pageManager.buttonNotifier,
                        builder: (_, value, __) {
                          switch (value) {
                            case ButtonState.loading:
                              return Container(
                                margin: const EdgeInsets.all(8.0),
                                width: 50.0,
                                height: 50.0,
                                child: const CircularProgressIndicator(),
                              );
                            case ButtonState.paused:
                              return IconButton(
                                icon: const Icon(
                                  Icons.play_circle_fill_outlined,
                                  color: Color(0xff444444),
                                ),
                                iconSize: 70.0,
                                onPressed: _pageManager.play,
                              );
                            case ButtonState.playing:
                              return IconButton(
                                icon: const Icon(
                                  Icons.pause_circle_filled_outlined,
                                  color: Color(0xff444444),
                                ),
                                iconSize: 70.0,
                                onPressed: _pageManager.pause,
                              );
                          }
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          _pageManager.seekForward();
                        },
                        icon: Image.asset('assets/seek_forward.png'),
                      ),
                      ValueListenableBuilder<int>(
                          valueListenable:
                              _pageManager.currentSongIndexNotifier,
                          builder: (_, value, __) {
                            return IconButton(
                              onPressed: () {
                                _pageManager.next();
                              },
                              icon: Icon(
                                Icons.skip_next,
                                color: value == 4 ? Colors.grey : Colors.black,
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 36, 10, 0),
                  child: Text(
                    'Track List',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    onPressed: () {
                      if (_controller.hasClients) {
                        final position = _controller.position.maxScrollExtent;
                        _controller.animateTo(
                          position,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                        );
                      }
                    },
                    icon: const Icon(FontAwesomeIcons.angleDown),
                  ),
                ),
                SizedBox(
                  height: 600,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (_, i) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: ListTile(
                        leading: ValueListenableBuilder2<int, bool>(
                          first: _pageManager.currentSongIndexNotifier,
                          second: _pageManager.songStatusNotifier,
                          builder: (_, songIdx, songStatus, __) {
                            return Container(
                              height: 54,
                              width: 54,
                              decoration: BoxDecoration(
                                color: const Color(0xff2F2E41),
                                borderRadius: BorderRadius.only(
                                    topLeft: songIdx == i
                                        ? const Radius.circular(19)
                                        : Radius.zero,
                                    topRight: songIdx == i
                                        ? const Radius.circular(19)
                                        : const Radius.circular(10),
                                    bottomLeft: songIdx == i
                                        ? const Radius.circular(19)
                                        : const Radius.circular(10),
                                    bottomRight: songIdx == i
                                        ? const Radius.circular(19)
                                        : const Radius.circular(10)),
                              ),
                              child: (songIdx == i)
                                  ? (songStatus == true)
                                      ? InkWell(
                                          onTap: () => _pageManager.pause(),
                                          child: const Icon(
                                            Icons.pause,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () => _pageManager.play(),
                                          child: const Icon(
                                            Icons.play_arrow_rounded,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        )
                                  : InkWell(
                                      onTap: () =>
                                          _pageManager.playSongAtIndex(i),
                                      child: const Icon(
                                        Icons.play_arrow_rounded,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                            );
                          },
                        ),
                        title: Text(getSongTitle(i),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                        ),
                        subtitle: const Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Text('Mutual Fund',
                          style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                          ),
                        ),
                        trailing: Text(
                          getSongDuration(i),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ValueListenableBuilder2<A, B> extends StatelessWidget {
  const ValueListenableBuilder2({
    required this.first,
    required this.second,
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  final ValueListenable<A> first;
  final ValueListenable<B> second;
  final Widget? child;
  final Widget Function(BuildContext context, A a, B b, Widget? child) builder;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<A>(
        valueListenable: first,
        builder: (_, a, __) {
          return ValueListenableBuilder<B>(
            valueListenable: second,
            builder: (context, b, __) {
              return builder(context, a, b, child);
            },
          );
        },
      );
}