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


- (void) speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    printf("Speech started");
    speaking = true;
}

- (void) speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance {
    printf("Speech paused");
    speaking = false;
}

- (void) speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance {
    printf("Speech continued");
    speaking = true;
}

- (void) speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {
    printf("Speech cancelled");
    speaking = false;
}

- (void) speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    printf("Speech finished");
    speaking = false;
}


+ (SpeechSynthesizer*) getInstance {
    if (instance == NULL) {
        instance = [[SpeechSynthesizer alloc] init];
    }
    
    return instance;
}

@end
