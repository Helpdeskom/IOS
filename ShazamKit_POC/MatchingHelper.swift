import AVFoundation
import ShazamKit

@available(iOS 15.0, *)
class MatchingHelper: NSObject {
  private var session: SHSession?
  private let audioEngine = AVAudioEngine()

  private var matchHandler: ((SHMatchedMediaItem?, Error?) -> Void)?
  typealias MatchWithContentHandler = ((SHMatchedMediaItem?, Error?) -> Void)
  private var matchWithContentHandler: MatchWithContentHandler?

  private var lastMatch: SHMatchedMediaItem?
//  private var lastAnnotationMatch: VideoAnnotation?

  // Initializer with match handler
  init(matchHandler handler: ((SHMatchedMediaItem?, Error?) -> Void)?) {
    matchHandler = handler
  }

  // Initializer with match and content handler
  init(matchWithContentHandler handler: MatchWithContentHandler?) {
    matchWithContentHandler = handler
  }

  // Function to start matching
  func match(catalog: SHCustomCatalog? = nil) throws {
    // Initialize session with custom catalog if provided
    if let catalog = catalog {
      session = SHSession(catalog: catalog)
    } else {
      session = SHSession()
    }

    // Set session delegate
    session?.delegate = self

    // Retrieve the input node's output format
    let inputNode = audioEngine.inputNode
    let inputNodeFormat = inputNode.outputFormat(forBus: 0)
    let sampleRate = inputNodeFormat.sampleRate

    // Create audio format with input node's sample rate and single channel (mono)
    guard let audioFormat = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1) else {
        throw NSError(domain: "Invalid audio format", code: -1, userInfo: nil)
    }

    // Install tap on the input node
    audioEngine.inputNode.installTap(onBus: 0, bufferSize: 2048, format: audioFormat) { [weak session] buffer, audioTime in
      session?.matchStreamingBuffer(buffer, at: audioTime)
    }

    // Set audio session category and request record permission
    try AVAudioSession.sharedInstance().setCategory(.record)
    AVAudioSession.sharedInstance().requestRecordPermission { [weak self] success in
      guard success, let self = self else { return }
      try? self.audioEngine.start()
    }
  }

  // Function to stop listening
  func stopListening() {
    audioEngine.stop()
    audioEngine.inputNode.removeTap(onBus: 0)
  }
}

// MARK: - SHSessionDelegate
@available(iOS 15.0, *)
extension MatchingHelper: SHSessionDelegate {
  func session(_ session: SHSession, didFind match: SHMatch) {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }

      // Handle match with simple handler
      if let handler = self.matchHandler {
        handler(match.mediaItems.first, nil)
        self.stopListening()
      }

      // Handle match with content handler
      /*if let handler = self.matchWithContentHandler {
        // Find the matched annotation based on the offset
        let matchedAnnotation = VideoAnnotation.sampleAnnotations.last { annotation in
          (match.mediaItems.first?.predictedCurrentMatchOffset ?? 0) > annotation.offset
        }

        // Call handler if new match or annotation found
        if match.mediaItems.first != self.lastMatch || matchedAnnotation != self.lastAnnotationMatch {
          handler(match.mediaItems.first, matchedAnnotation, nil)
          self.lastMatch = match.mediaItems.first
          self.lastAnnotationMatch = matchedAnnotation
        }
      }*/
    }
  }

  func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
    print("Did not find match for \(signature) | Error: \(String(describing: error))")
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }

      // Handle no match with simple handler
      if let handler = self.matchHandler {
        handler(nil, error)
        self.stopListening()
      }

      // Handle no match with content handler
      if let handler = self.matchWithContentHandler {
        handler(nil, error)
        self.stopListening()
      }
    }
  }
}
