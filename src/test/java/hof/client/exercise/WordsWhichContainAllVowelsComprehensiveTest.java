/*******************************************************************************
 * Copyright (C) 2016-2019 Dennis Cosgrove
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 ******************************************************************************/
package hof.client.exercise;

import edu.wustl.cse.cosgroved.junit.JUnitUtils;
import hof.clients.exercise.HofClients;
import immutable.list.core.ImListTestUtils;
import immutable.list.util.core.ImList;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.TestRule;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;

import java.util.*;

import static org.junit.Assert.*;

/**
 * @author Dennis Cosgrove (http://www.cse.wustl.edu/~cosgroved/)
 */
@RunWith(Parameterized.class)
public class WordsWhichContainAllVowelsComprehensiveTest {
	private final ImList<String> original;
	private final ImList<String> expected;

	public WordsWhichContainAllVowelsComprehensiveTest(List<String> original, List<String> expected) {
		this.original = ImListTestUtils.toImmutableList(original);
		this.expected = ImListTestUtils.toImmutableList(expected);
	}

	@Rule
	public TestRule timeout = JUnitUtils.createTimeoutRule();

	@Test
	public void test() {
		ImList<String> actual = HofClients.toOnlyWordsWhichContainAllVowels(original);
		assertEquals(expected, actual);
	}

	private static char nextRandomLetter() {
		Random random = new Random();
		return (char) ('a' + random.nextInt(26));
	}

	private static String nextRandomString() {
		return new String(new char[] { nextRandomLetter(), nextRandomLetter(), nextRandomLetter() });
	}

	private static Object[] createRandom(int size) {
		Random random = new Random();
		List<String> original = new ArrayList<>(size);
		List<String> expected = new LinkedList<>();

		String[] allWordsContainAllVowels = AllWordsContainAllVowelsTest.getAllWordsContainAllVowelsArray();
		for (int i = 0; i < size; ++i) {
			String s;
			if (random.nextBoolean()) {
				s = nextRandomString();
			} else {
				s = allWordsContainAllVowels[random.nextInt(allWordsContainAllVowels.length)];
				expected.add(s);
			}
			original.add(s);
		}
		return new Object[] { original, expected };
	}

	@Parameters(name = "original: {0}; expected: {1}")
	public static Collection<Object[]> getConstructorArguments() {
		List<Object[]> result = new LinkedList<>();
		result.add(new Object[] { Arrays.asList(), Arrays.asList() });
		result.add(new Object[] { Arrays.asList("b"), Arrays.asList() });
		result.add(new Object[] { Arrays.asList("a"), Arrays.asList() });
		result.add(new Object[] { Arrays.asList("e"), Arrays.asList() });
		result.add(new Object[] { Arrays.asList("i"), Arrays.asList() });
		result.add(new Object[] { Arrays.asList("o"), Arrays.asList() });
		result.add(new Object[] { Arrays.asList("u"), Arrays.asList() });
		result.add(new Object[] { Arrays.asList("aeiou"), Arrays.asList("aeiou") });
		result.add(new Object[] { Arrays.asList("b", "aeiou"), Arrays.asList("aeiou") });
		result.add(new Object[] { Arrays.asList("aeiou", "b"), Arrays.asList("aeiou") });
		for (int i = 0; i < 100; ++i) {
			result.add(createRandom(5));
		}
		return result;
	}
}
