// Generate S-box
package algo;

import java.util.Arrays;
import java.util.Random;


public class GenerateSBox {
    
    public static byte[] generateSBox(int SBOX_SIZE, byte[] seed, int offset) throws Exception {
        byte[] sbox = new byte[SBOX_SIZE];
        Random random = new Random(Arrays.hashCode(seed) + offset);

        // Initialize with identity mapping
        for (int i = 0; i < SBOX_SIZE; i++) {
            sbox[i] = (byte) i;
        }

        // Shuffle to generate S-box
        for (int i = 0; i < SBOX_SIZE; i++) {
            int j = random.nextInt(SBOX_SIZE);
            byte temp = sbox[i];
            sbox[i] = sbox[j];
            sbox[j] = temp;
        }

        return sbox;
    }
}
