package hof.clients.exercise;

import edu.wustl.cse.cosgroved.NotYetImplementedException;
import hof.util.exercise.Hof;
import immutable.list.util.core.ImList;
import immutable.list.util.exercise.ImLists;

import java.util.Optional;

/**
 * @author __STUDENT_NAME__
 * @author <a href="http://www.cse.wustl.edu/~dennis.cosgrove/">Dennis Cosgrove</a>
 */
public class HofClients {
    private static char[] LOWER_CASE_VOWELS = "aeiou".toCharArray();

    /**
     * Creates and returns a list whose contents are the words of the specified
     * input which contain each of the vowels 'a', 'e', 'i', 'o', and 'u'.
     * Note, 'y' is not considered.
     * The order in the input words must be preserved in the result.
     *
     * For example, if the input is ["parallel", "equation", "concurrent",
     * "tenacious"] then the returned list should be ["equation", "tenacious"].
     *
     * @param words the specified list of words
     * @return the list of words which contain each of the vowels
     */
    public static ImList<String> toOnlyWordsWhichContainAllVowels(ImList<String> words) {
        
            throw new NotYetImplementedException();
        
    }

    /**
     * Creates and returns a list whose contents are the even integers in the
     * specified input. The order in the input integers must
     * be preserved in the result.
     *
     * For example, if the input is [12, 71, 100, 231, 425, 2014, 2018] then the
     * returned list should be [12, 100, 2014, 2018].
     *
     * @param xs the specified list of integers
     * @return the list of specified integers which are even
     */
    public static ImList<Integer> toOnlyEvens(ImList<Integer> xs) {
        
            throw new NotYetImplementedException();
        
    }

    

    /**
     * Returns the first word in the specified list which is a palindrome.
     *
     * For example, if the input is ["ambulance", "kayak", "racecar", "train"] then
     * Optional.of("kayak") should be returned.
     *
     * For example, if the input is ["ambulance", "train"] then Optional.empty()
     * should be returned.
     *
     * @param words the specified list of words
     * @return the filtered list of specified words which contain each of the vowels
     */
    public static Optional<String> firstPalindrome(ImList<String> words) {
        
            throw new NotYetImplementedException();
        
    }

    public static int sum(ImList<Integer> xs) {
        
            throw new NotYetImplementedException();
        
    }

    public static int countBetweenMinAndMaxExclusive(int min, int maxExclusive, ImList<Integer> xs) {
        
            throw new NotYetImplementedException();
        
    }

    public static <E> ImList<E> reverse(ImList<E> xs) {
        
            throw new NotYetImplementedException();
        
    }

    /**
     * Returns a list whose contents are the lengths of the specified
     * input texts. The order in the input texts must be preserved in the result.
     *
     * For example, if the input is ["programming", "languages", "Dan"] then the
     * returned list should be [11, 9, 3].
     *
     * @param texts the specified list of texts
     * @return the lengths of the specified texts
     */
    public static ImList<Integer> toLengths(ImList<String> texts) {
        
            throw new NotYetImplementedException();
        
    }

    /**
     * Returns a list whose contents are the results of whether or not
     * the specified input items are strictly less than the specified threshold.
     *
     * For example, if the input list is
     *
     * [131, 71, 66, 99, 425, 231, 4, 12]
     *
     * and the threshold is 99 then the returned list should be
     *
     * [false, true, true, false, false, false, true, true].
     *
     * @param xs        the input list of values
     * @param threshold value used to determine less than
     * @return a list which holds whether or not each value is less than threshold
     *         or not
     */
    public static ImList<Boolean> toStrictlyLessThan(ImList<Integer> xs, int threshold) {
        
            throw new NotYetImplementedException();
        
    }
}
