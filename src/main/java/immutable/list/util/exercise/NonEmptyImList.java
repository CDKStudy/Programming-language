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
package immutable.list.util.exercise;

import edu.wustl.cse.cosgroved.NotYetImplementedException;
import immutable.list.util.core.ImList;

import java.util.Iterator;
import java.util.NoSuchElementException;
import java.util.Objects;

/**
 * @author Dekang Cao
 * @author Dennis Cosgrove (http://www.cse.wustl.edu/~cosgroved/)
 */
/* package-private */ final class NonEmptyImList<E> implements ImList<E> {
	

	/* package-private */ NonEmptyImList(E head, ImList<E> tail) {
		
			throw new NotYetImplementedException();
		
	}

	@Override
	public E head() {
		
			throw new NotYetImplementedException();
		
	}

	@Override
	public ImList<E> tail() {
		
			throw new NotYetImplementedException();
		
	}

	@Override
	public boolean isEmpty() {
		
			throw new NotYetImplementedException();
		
	}

	@Override
	public Iterator<E> iterator() {
		
			throw new NotYetImplementedException();
		
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) {
			return true;
		}
		if (o == null) {
			return false;
		}
		if (o instanceof ImList) {
			ImList<?> that = (ImList<?>) o;
			boolean thatEmpty = that.isEmpty();
			if (isEmpty()) {
				return thatEmpty;
			} else {
				if (thatEmpty) {
					return false;
				} else {
					return Objects.equals(head(), that.head()) && Objects.equals(tail(), that.tail());
				}
			}
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return Objects.hash(head(), tail());
	}

	@Override
	public String toString() {
		if (isEmpty()) {
			return "[]";
		} else {
			return head() + "::" + tail().toString();
		}
	}
}
