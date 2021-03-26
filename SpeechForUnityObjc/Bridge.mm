//
//  Bridge.m
//  SpeechForUnityObjc
//
//  Created by Алексей Крицков on 26.03.2021.
//

#import "Bridge.h"

char* cStringCopy(const char* string){
     if (string == NULL){
          return NULL;
     }
     char* res = (char*)malloc(strlen(string)+1);
     strcpy(res, string);
     return res;
}



extern "C" {
    void _speakText(char* text, char* lang, float rate) {
        NSString* textStr = [NSString stringWithUTF8String:text];
        NSString* langStr = [NSString stringWithUTF8String:lang];
        [[SpeechSynthesizer getInstance] speakText:textStr inLang:langStr atRate:rate];
    }
    
    bool _isNowSpeaking() {
        return false;
    }
    
    void _stopSpeaking() {
        [[SpeechSynthesizer getInstance] stopSpeaking];
    }
}
