package com.cypherstack.cs_monero_flutter_libs_android_armeabi_v7a

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlin.test.Test
import org.mockito.Mockito

/*
 * This demonstrates a simple unit test of the Kotlin portion of this plugin's implementation.
 *
 * Once you have built the plugin's example app, you can run these tests from the command
 * line by running `./gradlew testDebugUnitTest` in the `example/android/` directory, or
 * you can run them directly from IDEs that support JUnit such as Android Studio.
 */

internal class CsSalviumFlutterLibsAndroidArmeabiV7aPluginTest {
  @Test
  fun onMethodCall_getPlatformVersion_returnsExpectedValue() {
    val plugin = CsSalviumFlutterLibsAndroidArmeabiV7aPlugin()

    val call = MethodCall("getPlatformVersion", null)
    val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)
    plugin.onMethodCall(call, mockResult)

    Mockito.verify(mockResult).success("Android " + android.os.Build.VERSION.RELEASE)
  }
}
