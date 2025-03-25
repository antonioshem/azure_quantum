import Std.Logical.Xor;
import Microsoft.Quantum.Convert.*;
import Microsoft.Quantum.Math.*;

    operation Main() : Int {
        let max = 10;
        let min = 5;
        Message($"Sampling a random number between {min} and {max}: ");
    
        // Generate random number in the min..max range.
        return GenerateRandomNumberInRange(min, max);
    }
    
    /// Generates a random number between 0 and `max`.
    operation GenerateRandomNumberInRange(min : Int, max : Int) : Int {
        // Determine the number of bits needed to represent `max` and store it
        // in the `nBits` variable. Then generate `nBits` random bits which will
        // represent the generated random number.
        let rangesize = max - min + 1;
        mutable bits = [];
        let nBits = BitSizeI(rangesize -1);
        for idxBit in 0..(nBits - 1) {
            set bits += [GenerateRandomBit()];
        }
        let sample = ResultArrayAsInt(bits);
    
        // Return random number if it is within the requested range.
        // Generate it again if it is outside the range.
        return sample >= rangesize ? GenerateRandomNumberInRange(min, max) | (sample + min);
    }
    
    operation GenerateRandomBit() : Result {
        // Allocate a qubit.
        use q = Qubit();
    
        // Set the qubit into superposition of 0 and 1 using the Hadamard operation
        H(q);
    
        // Measure the qubit value using the `M` operation, and store the
        // measurement value in the `result` variable.
        let result = M(q);
    
        // Reset qubit to the |0〉 state.
        Reset(q);
    
        // Return the result of the measurement.
        return result;
    }