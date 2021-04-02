//
//  Bridge.h
//  SpeechForUnityObjc
//
//  Created by Алексей Крицков on 26.03.2021.
//

#ifndef Bridge_h
#define Bridge_h

#import "SpeechSynthesizer.h"

extern "C" {
    void _speakText(char* text, char* lang, float rate);
    bool _isNowSpeaking();
    void _stopSpeaking();
    void _setEventHandler(int code, SpeechSynthesizerDelegate delegate);
}

#endif /* Bridge_h */
