//SHA256.java
package algo;


import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.security.MessageDigest;

public class HMACSHA256 {

    /**
     * Generates an HMAC-SHA-256 hash using the given data and key.
     *
     * @param data The data to be hashed.
     * @param key  The key used for HMAC.
     * @return The HMAC-SHA-256 hash.
     * @throws Exception If any error occurs during hashing.
     */
    public static byte[] hmacSHA256(byte[] data, byte[] key) throws Exception {
        // Create Mac instance for HMAC with SHA-256
        Mac mac = Mac.getInstance("HmacSHA256");

        // Initialize with the key
        SecretKeySpec secretKeySpec = new SecretKeySpec(key, "HmacSHA256");
        mac.init(secretKeySpec);

        // Perform HMAC and return the result
        return mac.doFinal(data);
    }

    /**
     * Generates a SHA-256 hash of the provided byte array.
     *
     * @param data The data to be hashed.
     * @return The SHA-256 hash.
     * @throws Exception If any error occurs during hashing.
     */
    public static byte[] sha256Hash(byte[] data) throws Exception {
        // Create MessageDigest instance for SHA-256
        MessageDigest digest = MessageDigest.getInstance("SHA-256");

        // Perform SHA-256 hashing and return the result
        return digest.digest(data);
    }

    /**
     * Generates a SHA-256 hash of a string.
     *
     * @param input The string to be hashed.
     * @return The hexadecimal string representation of the SHA-256 hash.
     * @throws Exception If any error occurs during hashing.
     */
    public static String hash(String input) throws Exception {
        // Convert the input string to bytes
        byte[] data = input.getBytes();

        // Generate SHA-256 hash
        byte[] hashBytes = sha256Hash(data);

        // Convert the byte array to hexadecimal string and return
        StringBuilder hexString = new StringBuilder();
        for (byte b : hashBytes) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }

        return hexString.toString();
    }
}
