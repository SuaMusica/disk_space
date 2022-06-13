package br.com.suamusica.disk_space_android

import android.os.Environment
import android.os.StatFs
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.content.Context
import android.app.Activity
import androidx.annotation.Nullable
import io.flutter.plugin.common.BinaryMessenger


@Suppress("DEPRECATION")
internal class MethodCallHandlerImpl : MethodCallHandler{
    
    private var channel: MethodChannel? = null
    private val channelName = "plugins.suamusica.com.br/disk_space"
    private var context: Context? = null
    private var activity: Activity? = null

    fun startListening(context: Context?, messenger: BinaryMessenger?) {
        channel = MethodChannel(messenger!!, channelName)
        channel!!.setMethodCallHandler(this)
        this.context = context
    }

    fun setActivity(@Nullable activity: Activity?) {
        this.activity = activity
    }

    

    private fun getFreeDiskSpace(): Double {
        val stat = StatFs(Environment.getExternalStorageDirectory().path)

        val bytesAvailable: Long = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.JELLY_BEAN_MR2)
            stat.blockSizeLong * stat.availableBlocksLong
        else
            stat.blockSize.toLong() * stat.availableBlocks.toLong()
     
        return (bytesAvailable / (1024f * 1024f)).toDouble()
      }
    
      private fun getTotalDiskSpace(): Double {
        val stat = StatFs(Environment.getExternalStorageDirectory().path)

          val bytesAvailable: Long = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.JELLY_BEAN_MR2)
                stat.blockSizeLong * stat.blockCountLong
            else
                stat.blockSize.toLong() * stat.blockCount.toLong()
        return (bytesAvailable / (1024f * 1024f)).toDouble()
      }
    
    
      override fun onMethodCall(call: MethodCall, result: Result) {
        when(call.method) {
          "getFreeDiskSpace" -> result.success(getFreeDiskSpace())
          "getTotalDiskSpace" -> result.success(getTotalDiskSpace())
          else -> result.notImplemented()
        }
      }
}