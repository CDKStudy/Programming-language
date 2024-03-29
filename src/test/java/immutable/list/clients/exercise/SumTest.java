/*******************************************************************************
 * Copyright (C) 2016-2020 Dennis Cosgrove
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
package immutable.list.clients.exercise;

import immutable.list.core.ImListTestUtils;
import immutable.list.util.core.ImList;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;

import java.util.Arrays;
import java.util.Collection;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static immutable.list.util.exercise.ImLists.brackets;
import static immutable.list.util.exercise.ImLists.nil;

@RunWith(Parameterized.class)
/**
 * @author Dennis Cosgrove (http://www.cse.wustl.edu/~cosgroved/)
 */
public class SumTest extends AbstractApplyTest {
    public SumTest(int expected, ImList<Integer> input) {
        super(expected, input);
    }

    @Override
    protected int apply(ImList<Integer> input) {
        return SumProductCountdownFactorial.sum(input);
    }

    @Parameterized.Parameters(name = "expected: {0}; input: {1}")
    public static Collection<Object[]> getConstructorArguments() {
        return Arrays.asList(
                new Object[]{0, nil()},
                new Object[]{71, brackets(71)},
                new Object[]{12, brackets(3,4,5)},
                new Object[]{1863, brackets(1776, 4*20, 7)},
                new Object[]{99*50, ImListTestUtils.toImmutableList(IntStream.range(0, 100).boxed().collect(Collectors.toList()))}
        );
    }
}
