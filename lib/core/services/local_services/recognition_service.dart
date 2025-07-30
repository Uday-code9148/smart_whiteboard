import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';

class RecognitionService {
  final DigitalInkRecognizerModelManager _modelManager = DigitalInkRecognizerModelManager();

  /// Ensure the model for the given languageTag is downloaded
  Future<bool> ensureModelDownloaded(String languageTag) async {
    final isDownloaded = await _modelManager.isModelDownloaded(languageTag);
    if (!isDownloaded) {
      try {
        await _modelManager.downloadModel(languageTag);
      } catch (ex) {
        rethrow;
      }
      return true;
    } else {
      return false;
    }
  }

  /// Delete model if needed
  Future<void> deleteModel(String languageTag) async {
    await _modelManager.deleteModel(languageTag);
  }

  /// Recognize plain text handwriting
  Future<RecognitionCandidate?> recognizeNormalText(Ink ink) async {
    const languageTag = 'en-US';
    await ensureModelDownloaded(languageTag);
    final recognizer = DigitalInkRecognizer(languageCode: languageTag);

    try {
      final result = await recognizer.recognize(ink);
      return result.first;
    } catch (e) {
      return null;
    }
  }

  /// Recognize mathematical expressions
  Future<RecognitionCandidate?> recognizeMathText(Ink ink) async {
    const languageTag = 'zxx-x-Math';
    await ensureModelDownloaded(languageTag);
    final recognizer = DigitalInkRecognizer(languageCode: languageTag);

    try {
      final result = await recognizer.recognize(ink);
      return result.first;
    } catch (e) {
      print('Error recognizing math text: $e');
      return null;
    }
  }
}
