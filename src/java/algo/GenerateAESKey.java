//GenerateAESKey.java

package algo;

import java.security.SecureRandom;

public class GenerateAESKey {

    public static byte[] generateSalt() {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[16]; // 128-bit salt
        random.nextBytes(salt);
        return salt;
    }

    public static byte[] generateKey(String passphrase) throws Exception {
        byte[] salt = generateSalt();
        int iterations = 10000; // Recommended iterations for PBKDF2
        return KeyDerivation.deriveKey(passphrase, salt, iterations);
    }
}
