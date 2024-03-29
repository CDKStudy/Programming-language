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
package hof.util.exercise;

import edu.wustl.cse.cosgroved.junit.JUnitUtils;
import immutable.list.core.ImListTestUtils;
import immutable.list.util.core.ImList;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.TestRule;

import java.util.List;
import java.util.function.BiFunction;

import static org.junit.Assert.*;

/**
 * @author Dennis Cosgrove (http://www.cse.wustl.edu/~cosgroved/)
 */
public abstract class AbstractFoldTest {
	protected static interface FoldFunction {
		StringBuilder fold(BiFunction<String, StringBuilder, StringBuilder> f, StringBuilder acc,
				ImList<String> list);
	}

	private final ImList<String> list;
	private final String expected;
	private final FoldFunction foldFunction;

	public AbstractFoldTest(List<String> input, boolean isExpectedPrePended, FoldFunction foldFunction) {
		this.list = ImListTestUtils.toImmutableList(input);

		class MutableContainer {
			private StringBuilder sb;

			MutableContainer() {
				sb = new StringBuilder();
			}

			public void accept(String s) {
				if (isExpectedPrePended) {
					sb.insert(0, s);
				} else {
					sb.append(s);
				}
			}

			public void combine(MutableContainer other) {
				if (isExpectedPrePended) {
					sb.insert(0, other.sb);
				} else {
					sb.append(other.sb);
				}
			}

			public String finish() {
				return sb.toString();
			}
		}
		this.expected = input.stream()
				.collect(MutableContainer::new, MutableContainer::accept, MutableContainer::combine).finish();
		this.foldFunction = foldFunction;
	}

	@Rule
	public TestRule timeout = JUnitUtils.createTimeoutRule();

	@Test
	public void test() {
		StringBuilder actual = foldFunction.fold((v, acc) -> {
			acc.insert(0, v);
			return acc;
		}, new StringBuilder(), list);
		assertEquals(expected, actual.toString());
	}

}
