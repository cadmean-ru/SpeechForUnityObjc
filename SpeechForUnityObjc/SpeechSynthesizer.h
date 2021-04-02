//
//  SpeechSynthesizer.h
//  SpeechForUnityObjc
//
//  Created by Алексей Крицков on 26.03.2021.
//

#ifndef SpeechSynthesizer_h
#define SpeechSynthesizer_h

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void (*SpeechSynthesizerDelegate)(void);

@interface SpeechSynthesizer : NSObject <AVSpeechSynthesizerDelegate>

- (id) init;

- (void) speakText:(NSString*)str inLang:(NSString*)lang atRate:(float)rate;

- (bool) isNowSpeaking;

- (void) stopSpeaking;

- (void) setEventHandlerForCode:(int)code handler:(SpeechSynthesizerDelegate)h;

+ (SpeechSynthesizer*) getInstance;

@end

#endif /* SpeechSynthesizer_h */
