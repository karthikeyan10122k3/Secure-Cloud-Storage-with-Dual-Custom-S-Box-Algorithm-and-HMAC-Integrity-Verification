//KeyDerivation.java

package algo;

import java.security.SecureRandom;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.util.Arrays;

public class KeyDerivation {

    private static final int SALT_LENGTH = 16; // 128-bit salt
    private static final int KEY_LENGTH = 256; // 256-bit key
    private static final int HMAC_KEY_LENGTH = 128; // 128-bit HMAC key (first half of the key)

    /**
     * Generates a random salt of a predefined length.
     *
     * @return a byte array representing the random salt
     */
    public static byte[] generateRandomSalt() {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[SALT_LENGTH];
        random.nextBytes(salt);
        return salt;
    }

    /**
     * Derives a 256-bit encryption key using PBKDF2 with HMAC-SHA256.
     *
     * @param passphrase The passphrase to derive the key from
     * @param salt       The salt to use for derivation
     * @param iterations The number of iterations for the key derivation
     * @return a byte array representing the derived encryption key
     * @throws Exception if key derivation fails
     */
    public static byte[] deriveKey(String passphrase, byte[] salt, int iterations) throws Exception {
        PBEKeySpec spec = new PBEKeySpec(passphrase.toCharArray(), salt, iterations, KEY_LENGTH);
        SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
        return skf.generateSecret(spec).getEncoded();
    }

    /**
     * Extracts the HMAC key (first 128 bits) from a 256-bit encryption key.
     *
     * @param encryptionKey The 256-bit encryption key
     * @return a byte array representing the HMAC key
     */
    public static byte[] extractHMACKey(byte[] encryptionKey) {
        return Arrays.copyOfRange(encryptionKey, 0, HMAC_KEY_LENGTH / 8); // First 16 bytes
    }
}