import 'dart:io';
import 'package:untitled_client/src/models/customMultipartFile.dart';
import 'package:untitled_client/src/utils/globalUtils.dart';
import 'package:video_compress/video_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class UploadPostUtils {
  Future<CustomMultipartFile> getMultipartFile(
    File file, double startValue, double endValue, int fileHeight, int fileWidth
  ) async {
    CustomMultipartFile customMultipartFile;
    await VideoCompress.deleteAllCache();
    MediaInfo? mediaInfo = await VideoCompress.compressVideo(
      file.path,
      quality: VideoQuality.LowQuality,
      // includeAudio: false,
      startTime: (startValue.toInt() / 1000).round(),
      duration: ((endValue.toInt() / 1000) - (startValue.toInt() / 1000)).round(),
      fileHeight: fileHeight,
      fileWidth: fileWidth,
      frameRate: 40
    ).onError((error, stackTrace) {
      throw (error as Error);
    });

    customMultipartFile = await GlobalUtils().getCustomMultipartFileFromFile(
      mediaInfo!.file!
    );

    return customMultipartFile;
  }

  Future<CustomMultipartFile> getMultipartFileGif(
    File file, 
    double endValue
  ) async {
    CustomMultipartFile customMultipartFile;
    final FlutterFFmpeg _flutterFFmpeg = new FlutterFFmpeg();

    Directory directory = await getTemporaryDirectory();
    String _destinationPath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.gif';

    Duration startTime = Duration(milliseconds: 0);
    Duration durationTime = Duration(milliseconds: endValue > 300 ? 300 : endValue.toInt());

    String initCommand = '-i "${file.path}" ';
    String firstVideo = '[0]trim=start=$startTime:end=$durationTime,setpts=1.5*PTS,scale=300:-1:flags=lanczos[a]';
    String secondVideo = '[0]trim=start=$startTime:end=$durationTime,setpts=1.5*PTS,scale=300:-1:flags=lanczos,reverse[b]';
    String rest = '[a][b]concat=n=2:v=1:a=0,fps=10,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse';
    String videoOptions = initCommand + '-filter_complex "$firstVideo;$secondVideo;$rest" -loop 0 ';
    // String encode = videoOptions + '';
    String command = videoOptions + '"$_destinationPath"';

    await _flutterFFmpeg.execute(command).whenComplete(() {
      print('Got value');
      print('Video successfuly saved');
    }).catchError((error) {
      print('Error');
      print('Couldn\'t save the video');
    });

    customMultipartFile = await GlobalUtils().getCustomMultipartFileFromFile(
      File(_destinationPath) // File(response['onSuccess'])
    );

    return customMultipartFile;
  }

  Future<CustomMultipartFile> getMultipartFileImg(
    File videoFile,
  ) async {

    final thumbnailFile = await VideoThumbnail.thumbnailFile(
      video: videoFile.path,
      thumbnailPath: "${(await getTemporaryDirectory()).path}/${DateTime.now().millisecondsSinceEpoch}.jpg",
      imageFormat: ImageFormat.JPEG,
      maxWidth: 220, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 80,
    );

    CustomMultipartFile customMultipartFile = await GlobalUtils().getCustomMultipartFileFromFile(
      File(thumbnailFile!)
    );

    return customMultipartFile;
  }
}