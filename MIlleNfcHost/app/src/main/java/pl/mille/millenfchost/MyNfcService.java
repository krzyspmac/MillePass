package pl.mille.millenfchost;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.nfc.NdefRecord;
import android.nfc.cardemulation.HostApduService;
import android.os.Bundle;
import android.util.Log;
import android.view.Gravity;
import android.widget.Toast;

import java.math.BigInteger;
import java.nio.charset.Charset;

/**
 * Created by justin.ribeiro on 10/27/2014.
 *
 * The following definitions are based on two things:
 *   1. NFC Forum Type 4 Tag Operation Technical Specification, version 3.0 2014-07-30
 *   2. APDU example in libnfc: http://nfc-tools.org/index.php?title=Libnfc:APDU_example
 *
 */
public class MyNfcService extends HostApduService {

  private static final String TAG = "NFCLOL";

  private UserDatabase userDatabase = new UserDatabase();

  //
  // We use the default AID from the HCE Android documentation
  // https://developer.android.com/guide/topics/connectivity/nfc/hce.html
  //
  // Ala... <aid-filter android:name="F0394148148100" />
  //
  private static final byte[] APDU_SELECT = {
      (byte) 0x00, // CLA	- Class - Class of instruction
      (byte) 0xA4, // INS	- Instruction - Instruction code
      (byte) 0x04, // P1	- Parameter 1 - Instruction parameter 1
      (byte) 0x00, // P2	- Parameter 2 - Instruction parameter 2
      (byte) 0x07, // Lc field	- Number of bytes present in the data field of the command
      (byte) 0xF0, (byte) 0x39, (byte) 0x41, (byte) 0x48, (byte) 0x14, (byte) 0x81, (byte) 0x00, // NDEF Tag Application name
      (byte) 0x00  // Le field	- Maximum number of bytes expected in the data field of the response to the command
  };

  private static final byte[] APDU_DID_SIGN_IN = {
      (byte) 0xAA,  // CLA - Class Of Instruction
      (byte) 0xAF,  // Instruction
      (byte) 0x00,  // P1 - user identifier
      (byte) 0x00, // P2	- Parameter 2 - Instruction parameter 2
      (byte) 0x07, // Lc field	- Number of bytes present in the data field of the command
      (byte) 0xF0, (byte) 0x39, (byte) 0x41, (byte) 0x48, (byte) 0x14, (byte) 0x81, (byte) 0x00, // NDEF Tag Application name
      (byte) 0x00  // Le field	- Maximum number of bytes expected in the data field of the response to the command
  };

  private static final byte[] CAPABILITY_CONTAINER = {
      (byte) 0x00, // CLA	- Class - Class of instruction
      (byte) 0xa4, // INS	- Instruction - Instruction code
      (byte) 0x00, // P1	- Parameter 1 - Instruction parameter 1
      (byte) 0x0c, // P2	- Parameter 2 - Instruction parameter 2
      (byte) 0x02, // Lc field	- Number of bytes present in the data field of the command
      (byte) 0xe1, (byte) 0x03 // file identifier of the CC file
  };

  private static final byte[] READ_CAPABILITY_CONTAINER = {
      (byte) 0x00, // CLA	- Class - Class of instruction
      (byte) 0xb0, // INS	- Instruction - Instruction code
      (byte) 0x00, // P1	- Parameter 1 - Instruction parameter 1
      (byte) 0x00, // P2	- Parameter 2 - Instruction parameter 2
      (byte) 0x0f  // Lc field	- Number of bytes present in the data field of the command
  };

  // In the scenario that we have done a CC read, the same byte[] match
  // for ReadBinary would trigger and we don't want that in succession
  private boolean READ_CAPABILITY_CONTAINER_CHECK = false;

  private static final byte[] READ_CAPABILITY_CONTAINER_RESPONSE = {
      (byte) 0x00, (byte) 0x0F, // CCLEN length of the CC file
      (byte) 0x20, // Mapping Version 2.0
      (byte) 0x00, (byte) 0x3B, // MLe maximum 59 bytes R-APDU data size
      (byte) 0x00, (byte) 0x34, // MLc maximum 52 bytes C-APDU data size
      (byte) 0x04, // T field of the NDEF File Control TLV
      (byte) 0x06, // L field of the NDEF File Control TLV
      (byte) 0xE1, (byte) 0x04, // File Identifier of NDEF file
      (byte) 0x00, (byte) 0x32, // Maximum NDEF file size of 50 bytes
      (byte) 0x00, // Read access without any security
      (byte) 0x00, // Write access without any security
      (byte) 0x90, (byte) 0x00 // A_OKAY
  };

  private static final byte[] NDEF_SELECT = {
      (byte) 0x00, // CLA	- Class - Class of instruction
      (byte) 0xa4, // Instruction byte (INS) for Select command
      (byte) 0x00, // Parameter byte (P1), select by identifier
      (byte) 0x0c, // Parameter byte (P1), select by identifier
      (byte) 0x02, // Lc field	- Number of bytes present in the data field of the command
      (byte) 0xE1, (byte) 0x04 // file identifier of the NDEF file retrieved from the CC file
  };

  private static final byte[] NDEF_READ_BINARY_NLEN = {
      (byte) 0x00, // Class byte (CLA)
      (byte) 0xb0, // Instruction byte (INS) for ReadBinary command
      (byte) 0x00, (byte) 0x00, // Parameter byte (P1, P2), offset inside the CC file
      (byte) 0x02  // Le field
  };

  private static final byte[] NDEF_READ_BINARY_GET_NDEF = {
      (byte) 0x00, // Class byte (CLA)
      (byte) 0xb0, // Instruction byte (INS) for ReadBinary command
      (byte) 0x00, (byte) 0x00, // Parameter byte (P1, P2), offset inside the CC file
      (byte) 0x0f  //  Le field
  };

  private static final byte[] A_OKAY = {
      (byte) 0x90,  // SW1	Status byte 1 - Command processing status
      (byte) 0x00   // SW2	Status byte 2 - Command processing qualifier
  };

  private static final byte[] NOT_AUTH = {
      (byte) 0x45,  // SW1	Status byte 1 - Command processing status
      (byte) 0x12   // SW2	Status byte 2 - Command processing qualifier
  };

  private static final byte[] NDEF_ID = {
      (byte) 0xE1,
      (byte) 0x04
  };

  private NdefRecord NDEF_URI = new NdefRecord(
      NdefRecord.TNF_WELL_KNOWN,
      NdefRecord.RTD_TEXT,
      NDEF_ID,
      "Hello world!".getBytes(Charset.forName("UTF-8"))
  );
  private byte[] NDEF_URI_BYTES = NDEF_URI.toByteArray();
  private byte[] NDEF_URI_LEN = BigInteger.valueOf(NDEF_URI_BYTES.length).toByteArray();

  @SuppressLint("WrongConstant")
  @Override
  public int onStartCommand(Intent intent, int flags, int startId) {

    if (intent.hasExtra("ndefMessage")) {
      NDEF_URI = new NdefRecord(
          NdefRecord.TNF_WELL_KNOWN,
          NdefRecord.RTD_TEXT,
          NDEF_ID,
          intent.getStringExtra("ndefMessage").getBytes(Charset.forName("UTF-8"))
      );

      NDEF_URI_BYTES = NDEF_URI.toByteArray();
      NDEF_URI_LEN = BigInteger.valueOf(NDEF_URI_BYTES.length).toByteArray();

      Context context = getApplicationContext();
      CharSequence text = "Your NDEF text has been set!";
      int duration = Toast.LENGTH_SHORT;
      Toast toast = Toast.makeText(context, text, duration);
      toast.setGravity(Gravity.CENTER, 0, 0);
      toast.show();
    }

    Log.i(TAG, "onStartCommand() | NDEF" + NDEF_URI.toString());

    return 0;
  }

  @Override
  public byte[] processCommandApdu(byte[] commandApdu, Bundle extras) {

    //
    // The following flow is based on Appendix E "Example of Mapping Version 2.0 Command Flow"
    // in the NFC Forum specification
    //
    Log.i(TAG, "processCommandApdu() | incoming commandApdu: " + MyUtils.bytesToHex(commandApdu));

    // First command - sign in
    Log.i(TAG, "processCommandApdu() | command[0] = " + MyUtils.byteToInt(commandApdu[0]));

    if (MyUtils.byteToInt(commandApdu[0]) == 0xAA) {
      Log.i(TAG, "processCommandApdu() | incoming sign in action");

      byte userId = commandApdu[2];
      Log.i(TAG, "processCommandApdu() | user id = " + userId);

      User user = userDatabase.getUser(userId);
      if (user != null) {
        byte[] apdu_sign_in = {
            (byte) 0xAA,  // CLA - Class Of Instruction
            (byte) 0xAF,  // Instruction
            (byte) 0x00,  // P1 - user identifier
            (byte) 0x00, // P2	- Parameter 2 - Instruction parameter 2
            (byte) 0x07, // Lc field	- Number of bytes present in the data field of the command
            (byte) 0xF0, (byte) 0x39, (byte) 0x41, (byte) 0x48, (byte) 0x14, (byte) 0x81, (byte) 0x00, // NDEF Tag Application name
            (byte) 0x00  // Le field	- Maximum number of bytes expected in the data field of the response to the command
        };

        apdu_sign_in[2] = user.userIdentifier; // p1 user identifier

        return apdu_sign_in;
      } else {
        return NOT_AUTH;
      }
    }

    //
    // We're doing something outside our scope
    //
    //Log.wtf(TAG, "processCommandApdu() | I don't know what's going on!!!.");
    return "Can I help you?".getBytes();
  }

  @Override
  public void onDeactivated(int reason) {
    Log.i(TAG, "onDeactivated() Fired! Reason: " + reason);
  }
}