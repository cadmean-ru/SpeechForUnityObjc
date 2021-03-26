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

@interface SpeechSynthesizer : NSObject <AVSpeechSynthesizerDelegate>

- (id) init;

- (void) speakText:(NSString*)str inLang:(NSString*)lang atRate:(float)rate;

- (bool) isNowSpeaking;

- (void) stopSpeaking;

+ (SpeechSynthesizer*) getInstance;

@end

#endif /* SpeechSynthesizer_h */
