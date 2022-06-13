package br.com.suamusica.disk_space_android

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding


/** DiskSpaceAndroidPlugin */
class DiskSpaceAndroidPlugin: FlutterPlugin, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var context: Context? = null
  private var methodCallHandler: MethodCallHandlerImpl? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    methodCallHandler = MethodCallHandlerImpl()
    methodCallHandler!!.startListening(
      flutterPluginBinding.applicationContext, flutterPluginBinding.binaryMessenger
    )
    context = flutterPluginBinding.applicationContext
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }



  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    methodCallHandler!!.setActivity(binding.activity)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    return
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onDetachedFromActivity()
  }

  override fun onDetachedFromActivity() {}
}
