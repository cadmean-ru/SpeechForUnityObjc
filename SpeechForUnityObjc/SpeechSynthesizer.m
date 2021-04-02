//
//  SpeechSynthesizer.m
//  SpeechForUnityObjc
//
//  Created by Алексей Крицков on 26.03.2021.
//

#import "SpeechSynthesizer.h"

@implementation SpeechSynthesizer

AVSpeechSynthesizer* synthesizer;
static SpeechSynthesizer* instance;
bool speaking;

SpeechSynthesizerDelegate speakingStartedDelegate;
SpeechSynthesizerDelegate speakingFinishedDelegate;
SpeechSynthesizerDelegate speakingPausedDelegate;
SpeechSynthesizerDelegate speakingResumedDelegate;
SpeechSynthesizerDelegate speakingCancelledDelegate;


- (id) init {
    self = [super init];
    
    synthesizer = [[AVSpeechSynthesizer alloc] init];
    [synthesizer setDelegate: (id<AVSpeechSynthesizerDelegate>) self];
    
    return self;
}


- (void) speakText:(NSString *)str inLang:(NSString *)lang atRate:(float)rate {
    AVSpeechUtterance* u = [AVSpeechUtterance speechUtteranceWithString:str];
    u.rate = rate;
    u.voice = [AVSpeechSynthesisVoice voiceWithLanguage:lang];
    
    [synthesizer speakUtterance:u];
}

- (void) stopSpeaking {
    [synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

- (bool) isNowSpeaking {
    return speaking;
}

- (void) setEventHandlerForCode:(int)code handler:(SpeechSynthesizerDelegate)h {
    switch (code) {
        case 0:
            speakingStartedDelegate = h;
            break;
        case 1:
            speakingPausedDelegate = h;
            break;
        case 2:
            speakingResumedDelegate = h;
            break;
        case 3:
            speakingCancelledDelegate = h;
            break;
        case 4:
            speakingFinishedDelegate = h;
            break;
        default:
            break;
    }
}


- (void) speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    invokeDelegate(speakingStartedDelegate);
    speaking = true;
}

- (void) speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance {
    invokeDelegate(speakingPausedDelegate);
    speaking = false;
}

- (void) speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance {
    invokeDelegate(speakingResumedDelegate);
    speaking = true;
}

- (void) speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {
    invokeDelegate(speakingCancelledDelegate);
    speaking = false;
}

- (void) speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    invokeDelegate(speakingFinishedDelegate);
    speaking = false;
}


+ (SpeechSynthesizer*) getInstance {
    if (instance == NULL) {
        instance = [[SpeechSynthesizer alloc] init];
    }
    
    return instance;
}


void invokeDelegate(SpeechSynthesizerDelegate delegate) {
    if (delegate != NULL) {
        delegate();
    }
}

@end
