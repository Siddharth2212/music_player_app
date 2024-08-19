import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PageManager {
  final currentSongIndexNotifier = ValueNotifier<int>(0);
  final currentSongDurationNotifier = ValueNotifier<Duration>(Duration.zero);
  final currentSongTitleNotifier = ValueNotifier<String>('');
  final songStatusNotifier = ValueNotifier<bool>(false);
  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);

  static const url =
      'https://listen2re-audio-in.s3.ap-south-1.amazonaws.com/listen2re-uploads/History%2011th%20OLD/Ch%202%20%E0%A5%A7%E0%A5%AF%20%E0%A4%B5%E0%A5%8D%E0%A4%AF%E0%A4%BE%20%E0%A4%B6%E0%A4%A4%E0%A4%95%E0%A4%BE%E0%A4%A4%E0%A5%80%E0%A4%B2%20%E0%A4%AA%E0%A5%8D%E0%A4%B0%E0%A4%AC%E0%A5%8B%E0%A4%A7%E0%A4%A8/f-pri-h-11_128kbps.2.mp3?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIAQ3EGPZ3OKRTYZG72%2F20240819%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20240819T052043Z&X-Amz-Expires=504800&X-Amz-SignedHeaders=host&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEDUaCmFwLXNvdXRoLTEiSDBGAiEAlcnW7aA4hJU4fnUuRg5%2Bn263n%2F9kh34HwdqLh5oi4aMCIQCdo8KhH6kq3Qia4O3vhVZk2j4%2FxpXLdX%2FBRFWss4HGcyq%2FBQg%2BEAAaDDA1ODI2NDExMjg2MCIMVwKShcMExA%2FwVx4tKpwFGcEmP9f0QBA2LTVzXz8rRuBmfIE8mZDki%2Bj%2Brn7yALpc%2BFvmml6xnBwJsYFoLyNy3r0DR7D8I5h%2FWxhJSJIGb2m7blvwm7%2BeAQAqzdz0FplIrc29hobziCeVZuikbvhEnHLr0%2BECjARIS%2B2h22eNvAzxG%2F%2BE0SE0Mntp75UfVf6irlW%2Bp9Hl8MPlNIuqa2tWJc%2BD3aLKqEj2%2Buaxs1ZA6fCPRA7lo8%2FS01QhWia9M6Zl1gUhfL1lJq8v1P%2FnW66IrRz6RZW6B02aAMfhz71iYcbBT%2B%2BtjMC0aayQ3WTtgcGFdMbnFYYj9Ljkfm6%2Bz9dnIA%2BeqykqugNErPyNhcxFkcPLAFoXWLIDhMCA4NPGwZhIqTpABANBFAkxRe9ak9uWaZqQoENeS%2BnAnTJwueCvXWWwV7%2FZD101K1SiEktOL9Rxyrw5TW%2Bdr7Mlj4jTAmd6K1jmATqL%2B7E%2BFAR8qLTdJzpUHcx29XWumxB6370guas0WoWsOMaIJsnN2%2FdiHT%2FrafoKMbNx5lAm82%2F1YHwpKxLCZKLfoLwuWKDSbykr9isWdVOfGT0lMlHKIDO5Vsdh%2BDAiktFbuf%2Bklu6v%2Fw4YdcDwrJcNklCZ2mb4Fzhsk3Uv2W%2F%2FB9jHKSk7Fl%2B1uFQq8Z1pL3dWp6oIH9SrJCFRYaMW%2FFSkMoCwv8pcu2qwah4Tsf%2BLaXtq7gwdZ%2BlYRa8jLIMOOrJZt6Fl0Pygd9j%2FnYo7Dxl7WTCxyME7wXuhIK7lmRsPNqf1XoF4uiOpizcv%2Bg1jIEwHljeeXeXutY0S9rRMQfs3kAJVXxLcZqktSxrRobWdezsCQ0gmk6mEBfSPQGIhjuBZRuFxEJjEZCTY%2BxR1ngPCpYdkzu4CSabdy%2F360ToFSYle%2BUw4uREwip2LtgY6sAEssrJ2I8qgRgfyG2M2c4CdF34YhT7MZQ82C1f2Qsi3KyzcT%2FBuWrJ9EGZrqlHjP%2Fn4Deek9R03EW%2BVlnFUx1H1NY4DU2GSj24dYivzIzSkNnLS3Rf%2BPsdU0etF2ebvQB765rkIlonv9OnGr0TbpSGbzaHXaaoLzfG8cWV4oqljeHhR1i23sL%2ByDhBR3F0h3bcAwRQsmBVikF9%2BKnS%2FkubmuJ4fYJ0clHxiE2EMXhAPzQ%3D%3D&X-Amz-Signature=f61b0448f30069ff74872d05ed21aa2784a166e12a67c13dd755c55605ccc4fc';

  late AudioPlayer _audioPlayer;
  PageManager() {
    _init();
  }

  void _init() async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        // Start loading next item just before reaching it.
        useLazyPreparation: true, // default
        // Customise the shuffle algorithm.
        shuffleOrder: DefaultShuffleOrder(), // default
        // Specify the items in the playlist.
        children: [
          AudioSource.uri(
            Uri.parse(
                'https://listen2re-audio-in.s3.ap-south-1.amazonaws.com/listen2re-uploads/History%2011th%20OLD/Ch%202%20%E0%A5%A7%E0%A5%AF%20%E0%A4%B5%E0%A5%8D%E0%A4%AF%E0%A4%BE%20%E0%A4%B6%E0%A4%A4%E0%A4%95%E0%A4%BE%E0%A4%A4%E0%A5%80%E0%A4%B2%20%E0%A4%AA%E0%A5%8D%E0%A4%B0%E0%A4%AC%E0%A5%8B%E0%A4%A7%E0%A4%A8/f-pri-h-11_128kbps.2.mp3?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIAQ3EGPZ3OKRTYZG72%2F20240819%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20240819T052043Z&X-Amz-Expires=504800&X-Amz-SignedHeaders=host&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEDUaCmFwLXNvdXRoLTEiSDBGAiEAlcnW7aA4hJU4fnUuRg5%2Bn263n%2F9kh34HwdqLh5oi4aMCIQCdo8KhH6kq3Qia4O3vhVZk2j4%2FxpXLdX%2FBRFWss4HGcyq%2FBQg%2BEAAaDDA1ODI2NDExMjg2MCIMVwKShcMExA%2FwVx4tKpwFGcEmP9f0QBA2LTVzXz8rRuBmfIE8mZDki%2Bj%2Brn7yALpc%2BFvmml6xnBwJsYFoLyNy3r0DR7D8I5h%2FWxhJSJIGb2m7blvwm7%2BeAQAqzdz0FplIrc29hobziCeVZuikbvhEnHLr0%2BECjARIS%2B2h22eNvAzxG%2F%2BE0SE0Mntp75UfVf6irlW%2Bp9Hl8MPlNIuqa2tWJc%2BD3aLKqEj2%2Buaxs1ZA6fCPRA7lo8%2FS01QhWia9M6Zl1gUhfL1lJq8v1P%2FnW66IrRz6RZW6B02aAMfhz71iYcbBT%2B%2BtjMC0aayQ3WTtgcGFdMbnFYYj9Ljkfm6%2Bz9dnIA%2BeqykqugNErPyNhcxFkcPLAFoXWLIDhMCA4NPGwZhIqTpABANBFAkxRe9ak9uWaZqQoENeS%2BnAnTJwueCvXWWwV7%2FZD101K1SiEktOL9Rxyrw5TW%2Bdr7Mlj4jTAmd6K1jmATqL%2B7E%2BFAR8qLTdJzpUHcx29XWumxB6370guas0WoWsOMaIJsnN2%2FdiHT%2FrafoKMbNx5lAm82%2F1YHwpKxLCZKLfoLwuWKDSbykr9isWdVOfGT0lMlHKIDO5Vsdh%2BDAiktFbuf%2Bklu6v%2Fw4YdcDwrJcNklCZ2mb4Fzhsk3Uv2W%2F%2FB9jHKSk7Fl%2B1uFQq8Z1pL3dWp6oIH9SrJCFRYaMW%2FFSkMoCwv8pcu2qwah4Tsf%2BLaXtq7gwdZ%2BlYRa8jLIMOOrJZt6Fl0Pygd9j%2FnYo7Dxl7WTCxyME7wXuhIK7lmRsPNqf1XoF4uiOpizcv%2Bg1jIEwHljeeXeXutY0S9rRMQfs3kAJVXxLcZqktSxrRobWdezsCQ0gmk6mEBfSPQGIhjuBZRuFxEJjEZCTY%2BxR1ngPCpYdkzu4CSabdy%2F360ToFSYle%2BUw4uREwip2LtgY6sAEssrJ2I8qgRgfyG2M2c4CdF34YhT7MZQ82C1f2Qsi3KyzcT%2FBuWrJ9EGZrqlHjP%2Fn4Deek9R03EW%2BVlnFUx1H1NY4DU2GSj24dYivzIzSkNnLS3Rf%2BPsdU0etF2ebvQB765rkIlonv9OnGr0TbpSGbzaHXaaoLzfG8cWV4oqljeHhR1i23sL%2ByDhBR3F0h3bcAwRQsmBVikF9%2BKnS%2FkubmuJ4fYJ0clHxiE2EMXhAPzQ%3D%3D&X-Amz-Signature=f61b0448f30069ff74872d05ed21aa2784a166e12a67c13dd755c55605ccc4fc'),
            tag: 'SIP-Tiny',
          ),
          AudioSource.uri(
            Uri.parse(
                'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3'),
            tag: 'Savings Equation',
          ),
          AudioSource.uri(
            Uri.parse(
                'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3'),
            tag: 'Pay yourself first',
          ),
          AudioSource.uri(
            Uri.parse(
                'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3'),
            tag: 'Identify your financial goals',
          ),
          AudioSource.uri(
            Uri.parse(
                'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'),
            tag: 'Priorities yourself financial goals',
          ),
        ],
      ),
      // Playback will be prepared to start from track1.mp3
      initialIndex: 0, // default
      // Playback will be prepared to start from position zero.
      initialPosition: Duration.zero, // defaulT
    );

    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        buttonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        buttonNotifier.value = ButtonState.paused;
        songStatusNotifier.value = false;
      } else if (processingState != ProcessingState.completed) {
        buttonNotifier.value = ButtonState.playing;
        songStatusNotifier.value = true;
      } else {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });

    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });

    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });

    _audioPlayer.durationStream.listen((totalDuration) {
      final songIndex = _audioPlayer.playbackEvent.currentIndex;
      currentSongIndexNotifier.value = songIndex!;
      currentSongDurationNotifier.value = totalDuration!;
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration,
      );
    });

    _audioPlayer.sequenceStateStream.listen((sequenceState) {
      if (sequenceState == null) return;
      final currentItem = sequenceState.currentSource;
      final title = currentItem?.tag as String?;
      currentSongTitleNotifier.value = title ?? '';
    });
  }

  int? currentSongIndex() {
    return _audioPlayer.currentIndex ?? 0;
  }

  void play() {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void previous() {
    _audioPlayer.hasPrevious ? _audioPlayer.seekToPrevious() : null;
  }

  void next() {
    _audioPlayer.hasNext ? _audioPlayer.seekToNext() : null;
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void seekBackward() {
    _audioPlayer.seek(Duration(seconds: _audioPlayer.position.inSeconds - 10));
  }

  void seekForward() {
    _audioPlayer.seek(Duration(seconds: _audioPlayer.position.inSeconds + 10));
  }

  void playSongAtIndex(int songIndex) {
    _audioPlayer
        .seek(Duration.zero, index: songIndex)
        .then((value) => _audioPlayer.play());
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}

class ProgressBarState {
  ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });
  final Duration current;
  final Duration buffered;
  final Duration total;
}

enum ButtonState { paused, playing, loading }
