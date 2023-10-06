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

import edu.wustl.cse.cosgroved.NotYetImplementedException;
import immutable.list.clients.exercise.Length;
import immutable.list.util.challenge.SingletonEmptyImList;
import immutable.list.util.core.ImList;
import immutable.list.util.exercise.EmptyImList;
import immutable.list.util.exercise.ImLists;
import org.checkerframework.checker.units.qual.A;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.function.BiFunction;
import java.util.function.Function;
import java.util.function.Predicate;

import static immutable.list.util.exercise.ImLists.*;

/**
 * @author Dekang Cao
 * @author Dennis Cosgrove (http://www.cse.wustl.edu/~cosgroved/)
 */
public class Hof {

	/**
	 * Creates and returns a list whose contents are the filtered result of the
	 * specified input's elements which pass the predicate's test. The order in the
	 * input must be preserved in the result.
	 * 
	 * @see <a href="http://sml-family.org/Basis/list.html#SIG:LIST.filter:VAL">SML
	 *      filter</a>
	 * 
	 * @param <E>       input and result list item type
	 * @param predicate predicate to test each item in the specified list as to
	 *                  whether it should be included or not in the result.
	 * @param list      the specified list of items.
	 * @return a list consisting of the elements which pass the predicate's test
	 */
	public static <E> ImList<E> filter(Predicate<E> predicate, ImList<E> list) {
		if (list.isEmpty()) {
			return ImLists.nil();
		} else {
			E head = list.head();
			ImList<E> tail = list.tail();
			if (predicate.test(head)) {
				return ImLists.cons(head, filter(predicate, tail));
			} else {
				return filter(predicate, tail);
			}
		}
	}

	public static <E, R> R foldLeft(BiFunction<E, R, R> f, R acc, ImList<E> list) {
		if (list.isEmpty()) {
			return acc;
		} else {
			E head = list.head();
			ImList<E> tail = list.tail();
			R newAcc = f.apply(head, acc);
			return foldLeft(f, newAcc, tail);
		}
	}

	public static <E, R> R foldRight(BiFunction<E, R, R> f, R acc, ImList<E> list) {

		if (list.isEmpty()) {
			return acc;
		} else {
			E head = list.head();
			ImList<E> tail = list.tail();
			R recursiveResult = foldRight(f, acc, tail);
			return f.apply(head, recursiveResult);
		}
		
	}

	/**
	 * Creates and returns a list whose contents are the result applying the
	 * Function f to each item in the specified list. The order in the input must be
	 * preserved in the result.
	 *
	 * @see <a href="http://sml-family.org/Basis/list.html#SIG:LIST.map:VAL">SML
	 *      map</a>
	 *
	 * @param <E>  input list item type
	 * @param <R>  result list item type
	 * @param f    function to apply each item.
	 * @param list the specified list of items.
	 * @return a list of the mapped results.
	 */
	public static <E, R> ImList<R> map(Function<E, R> f, ImList<E> list) {
		if (list.isEmpty()) {
			return ImLists.nil();
		} else {
			E head = list.head();
			ImList<E> tail = list.tail();
			R mappedValue = f.apply(head);
			return ImLists.cons(mappedValue, map(f, tail));
		}
	}

	/**
	 * Searches the list from front to back until a element is found which passes
	 * the predicate.
	 *
	 * @see <a href="http://sml-family.org/Basis/list.html#SIG:LIST.find:VAL">SML
	 *      find</a>
	 *
	 * @param <E>       input and result list item type
	 * @param predicate predicate to test each item in the specified list as to
	 *                  whether it should be included or not in the result.
	 * @param list      the specified list of items.
	 * @return Optional of the item, if found. Otherwise, empty.
	 */
	public static <E> Optional<E> find(Predicate<E> predicate, ImList<E> list) {
		if (list.isEmpty()) {
			return Optional.empty();
		} else {
			E head = list.head();
			ImList<E> tail = list.tail();
			if (predicate.test(head)) {
				return Optional.of(head);
			} else {
				return find(predicate, tail);
			}
		}
	}


}
