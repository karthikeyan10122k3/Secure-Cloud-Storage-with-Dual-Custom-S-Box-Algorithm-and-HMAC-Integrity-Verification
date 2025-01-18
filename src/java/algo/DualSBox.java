package algo;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.crypto.spec.IvParameterSpec;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.Random;

public class DualSBox {
    private static final int AES_BLOCK_SIZE = 16;
    private static final int SBOX_SIZE = 256;
    private final byte[] S1;
    private final byte[] S2;
    private final byte[] invS1;
    private final byte[] invS2;

    // Constructor
    public DualSBox(String skey) throws Exception {
        byte[] keyBytes = skey.getBytes(StandardCharsets.UTF_8);
        this.S1 = GenerateSBox.generateSBox(SBOX_SIZE, keyBytes, 0);
        this.S2 = GenerateSBox.generateSBox(SBOX_SIZE, keyBytes, 1);
        this.invS1 = generateInverseSBox(S1);
        this.invS2 = generateInverseSBox(S2);
    }

    private static byte[] generateInverseSBox(byte[] sbox) {
        byte[] inverseSbox = new byte[sbox.length];
        for (int i = 0; i < sbox.length; i++) {
            inverseSbox[sbox[i] & 0xFF] = (byte) i;
        }
        return inverseSbox;
    }

    public String encrypt(String key, String plaintext) throws Exception {
        byte[] keyBytes = Arrays.copyOf(key.getBytes(StandardCharsets.UTF_8), AES_BLOCK_SIZE);
        SecretKeySpec secretKeySpec = new SecretKeySpec(keyBytes, "AES");
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");

        byte[] transformedPlaintext = applyDualSBoxToData(plaintext.getBytes(StandardCharsets.UTF_8));
        byte[] iv = new byte[AES_BLOCK_SIZE];
        new Random().nextBytes(iv);

        cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec, new IvParameterSpec(iv));
        byte[] encryptedBytes = cipher.doFinal(transformedPlaintext);
        String hash = HMACSHA256.hash(bytesToHex(encryptedBytes));

        return bytesToHex(iv) + ":" + bytesToHex(encryptedBytes) + ":" + hash;
    }

    public String decrypt(String key, String encryptedDataWithHash) throws Exception {
        String[] parts = encryptedDataWithHash.split(":");
        if (parts.length != 3) {
            throw new Exception("Invalid encrypted data format.");
        }

        String ivHex = parts[0];
        String encryptedData = parts[1];
        String expectedHash = parts[2];

        byte[] iv = hexToBytes(ivHex);
        byte[] encryptedBytes = hexToBytes(encryptedData);

        String hash = HMACSHA256.hash(bytesToHex(encryptedBytes));
        if (!hash.equals(expectedHash)) {
            System.out.println("DATA CHECK FAILED!!!!!!!!!");
            throw new Exception("Data integrity check failed!");
        }

        byte[] keyBytes = Arrays.copyOf(key.getBytes(StandardCharsets.UTF_8), AES_BLOCK_SIZE);
        SecretKeySpec secretKeySpec = new SecretKeySpec(keyBytes, "AES");
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.DECRYPT_MODE, secretKeySpec, new IvParameterSpec(iv));

        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
        byte[] originalData = reverseDualSBox(decryptedBytes);

        return new String(originalData, StandardCharsets.UTF_8);
    }

    private byte[] applyDualSBoxToData(byte[] data) {
        byte[] transformedData = Arrays.copyOf(data, data.length);
        for (int round = 1; round <= 20; round++) {
            if (round % 2 == 1) {
                applySBox(transformedData, S1);
            } else {
                applySBox(transformedData, S2);
            }
        }
        return transformedData;
    }

    private byte[] reverseDualSBox(byte[] data) {
        byte[] revertedData = Arrays.copyOf(data, data.length);
        for (int round = 20; round >= 1; round--) {
            if (round % 2 == 1) {
                applySBox(revertedData, invS1);
            } else {
                applySBox(revertedData, invS2);
            }
        }
        return revertedData;
    }

    private void applySBox(byte[] data, byte[] sbox) {
        for (int i = 0; i < data.length; i++) {
            data[i] = sbox[data[i] & 0xFF];
        }
    }

    public String bytesToHex(byte[] bytes) {
        StringBuilder hexString = new StringBuilder();
        for (byte b : bytes) {
            hexString.append(String.format("%02x", b));
        }
        return hexString.toString();
    }

    private byte[] hexToBytes(String hexString) {
        int len = hexString.length() / 2;
        byte[] result = new byte[len];
        for (int i = 0; i < len; i++) {
            result[i] = (byte) Integer.parseInt(hexString.substring(i * 2, i * 2 + 2), 16);
        }
        return result;
    }

}
