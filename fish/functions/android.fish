
#!/bin/fish

set -gx ANDROID_API_VERSION 25
set -gx ANDROID_NDK_HOME $HOME/android-ndk-r{$ANDROID_API_VERSION}c

function android --description 'setup android clang'
   if set -q ANDROID_NDK_HOME 
        set  ANDROID_CLANG $ANDROID_NDK_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin
        set -gx PATH $ANDROID_CLANG $PATH
   else
        echo "Failed setting android clang"
   end
end
