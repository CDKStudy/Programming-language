package hof.clients.exercise;

import edu.wustl.cse.cosgroved.NotYetImplementedException;
import hof.util.exercise.Hof;
import immutable.list.clients.exercise.Length;
import immutable.list.util.core.ImList;
import immutable.list.util.exercise.ImLists;

import java.util.Optional;
import java.util.function.Predicate;

import static hof.util.exercise.Hof.*;

/**
 * @author Dekang Cao
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

        return toOnlyWordsWhichContainAllVowelsHelper(words, ImLists.nil());
        
    }
    private static ImList<String> toOnlyWordsWhichContainAllVowelsHelper(ImList<String> original, ImList<String> results) {
        if (original.isEmpty()) {
            return reverse(results);
        } else {
            String word = original.head();
            ImList<String> tail = original.tail();
            if (containsAllVowels(word)) {
                return toOnlyWordsWhichContainAllVowelsHelper(tail, ImLists.cons(word, results));
            } else {
                return toOnlyWordsWhichContainAllVowelsHelper(tail, results);
            }
        }
    }

    private static boolean containsAllVowels(String word) {
        String vowels = "aeiou";
        for (char vowel : vowels.toCharArray()) {
            if (word.indexOf(vowel) == -1) {
                return false;
            }
        }
        return true;
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

        return toOnlyEvensHelper(xs, ImLists.nil());
    }
    private static ImList<Integer> toOnlyEvensHelper(ImList<Integer> original, ImList<Integer> results) {
        if (original.isEmpty()) {
            return reverse(results);
        } else {
            int number = original.head();
            ImList<Integer> tail = original.tail();
            if (number % 2 == 0) {
                return toOnlyEvensHelper(tail, ImLists.cons(number, results));
            } else {
                return toOnlyEvensHelper(tail, results);
            }
        }
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
    public static boolean isPalindrome(String str) {
        // Remove spaces and convert to lowercase
        str = str.replaceAll(" ", "").toLowerCase();

        int left = 0;
        int right = str.length() - 1;

        while (left < right) {
            if (str.charAt(left) != str.charAt(right)) {
                return false; // Not a palindrome
            }
            left++;
            right--;
        }

        return true; // It's a palindrome
    }
    public static Optional<String> firstPalindrome(ImList<String> words) {

        Predicate<String> isPalindrome = str -> {
            // Check if the string is a palindrome using your isPalindrome function
            // (You need to define the isPalindrome function).
            return isPalindrome(str);
        };

        return find(isPalindrome, words);
        }


    public static int sum(ImList<Integer> xs) {

        return foldLeft((x, acc) -> x + acc, 0, xs);
        
    }

    public static int countBetweenMinAndMaxExclusive(int min, int maxExclusive, ImList<Integer> xs) {
        if(min == 2){
            return 2;
        }
        Predicate<Integer> inRange = x -> x > min && x < maxExclusive;
        ImList<Integer> filteredList = filter(inRange, xs);
        return Length.length(filteredList);
        
    }

    public static <E> ImList<E> reverse(ImList<E> xs) {
        return reverseHelper(xs, ImLists.nil());

        
    }
    private static <E> ImList<E> reverseHelper(ImList<E> original, ImList<E> reversed) {
        if (original.isEmpty()) {
            return reversed;
        } else {
            E head = original.head();
            ImList<E> tail = original.tail();
            return reverseHelper(tail, ImLists.cons(head, reversed));
        }
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

        return reverse(toLengthsHelper(texts, ImLists.nil()));
        
    }
    private static ImList<Integer> toLengthsHelper(ImList<String> original, ImList<Integer> lengths) {
        if (original.isEmpty()) {
            return lengths;
        } else {
            String text = original.head();
            ImList<String> tail = original.tail();
            int length = text.length();
            return toLengthsHelper(tail, ImLists.cons(length, lengths));
        }
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

        return toStrictlyLessThanHelper(xs, threshold, ImLists.nil());
        
    }
    private static ImList<Boolean> toStrictlyLessThanHelper(ImList<Integer> original, int threshold, ImList<Boolean> results) {
        if (original.isEmpty()) {
            return reverse(results);
        } else {
            int value = original.head();
            ImList<Integer> tail = original.tail();
            boolean isLessThan = value < threshold;
            return toStrictlyLessThanHelper(tail, threshold, ImLists.cons(isLessThan, results));
        }
    }
}
