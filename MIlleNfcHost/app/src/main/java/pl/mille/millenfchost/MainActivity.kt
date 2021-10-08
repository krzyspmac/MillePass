package pl.mille.millenfchost

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.content.Intent


class MainActivity : AppCompatActivity() {
    val TAG = "NFCLOL"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        Log.v(TAG, "App started")
        val button = findViewById<Button>(R.id.buttonStartService)
        button.setOnClickListener {
            startService()
        }

    }

    fun startService() {
        /*val serviceIntent = Intent(this, MyNfcService::class.java)

        startService(serviceIntent)
        Log.v("NFCLOL", "start tapped")*/
    }
}