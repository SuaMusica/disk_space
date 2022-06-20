package br.com.suamusica.disk_space_android

import android.app.Activity
import android.content.Context
import android.os.Build
import android.os.Environment
import android.os.StatFs
import android.util.Log
import androidx.annotation.Nullable
import androidx.annotation.RequiresApi
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


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

    @RequiresApi(Build.VERSION_CODES.KITKAT)
    private fun getFreeSdSpace(): Double? {
        val spaces = getFreeSpaces()
        try {
            val sdSpace = spaces[1]["availableBytes"] as Long?
            if(sdSpace != null){
                return (sdSpace / (1024f * 1024f)).toDouble()
            }
        } catch (e: Exception){
            Log.e("DISK_SPACE", e.toString())
        }

        return null
    }

    @RequiresApi(Build.VERSION_CODES.KITKAT)
    private fun hasSdCard(): Boolean{
        val appsDir = context!!.getExternalFilesDirs(null)
        Log.d("DISK_SPACE", appsDir.size.toString())
        return appsDir.size > 1
    }

    @RequiresApi(Build.VERSION_CODES.KITKAT)
    private fun getFreeSpaces(): ArrayList<HashMap<String, Any>> {
        val appsDir = context!!.getExternalFilesDirs(null)
        val extRootPaths = arrayListOf<HashMap<String, Any>>()
        for (file in appsDir) {
            val path = file.absolutePath
            val statFs = StatFs(path)
            val availableBytes = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
                statFs.availableBlocksLong * statFs.blockSizeLong
            } else {
                statFs.blockSize.toLong() * statFs.blockCount.toLong()
            }
            val storageData: HashMap<String, Any> = HashMap()
            try {
                val rootPath = ""
                storageData["rootPath"] = rootPath
            } catch (e: Exception) {
            }
            storageData["path"] = path
            storageData["availableBytes"] = availableBytes
            extRootPaths.add(storageData)
        }
        return extRootPaths
    }

    
      private fun getTotalDiskSpace(): Double {
        val stat = StatFs(Environment.getExternalStorageDirectory().path)

          val bytesAvailable: Long = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2)
                stat.blockSizeLong * stat.blockCountLong
            else
                stat.blockSize.toLong() * stat.blockCount.toLong()
        return (bytesAvailable / (1024f * 1024f)).toDouble()
      }


    
      @RequiresApi(Build.VERSION_CODES.KITKAT)
      override fun onMethodCall(call: MethodCall, result: Result) {
        when(call.method) {
            "getFreeDiskSpace" -> result.success(getFreeDiskSpace())
            "getTotalDiskSpace" -> result.success(getTotalDiskSpace())
            "getFreeSdSpace" -> result.success(getFreeSdSpace())
            "hasSdCard" -> result.success(hasSdCard())
            else -> result.notImplemented()
        }
      }
}