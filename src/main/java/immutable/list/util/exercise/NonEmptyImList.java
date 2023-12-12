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
	 E head;
	 ImList<E> tail;

	/* package-private */
	    NonEmptyImList(E head, ImList<E> tail) {
		    this.head = head;
			this.tail = tail;
		
	}

	@Override
	public E head() {
		
			return head;
		
	}

	@Override
	public ImList<E> tail() {
		
			return tail;
		
	}

	@Override
	public boolean isEmpty() {
		
			return false;
		
	}

	@Override
	public Iterator<E> iterator() {
		return new Iterator<E>() {
			private ImList<E> cur = NonEmptyImList.this;
			@Override
			public boolean hasNext() {
				if(cur != null && !cur.isEmpty()){
					return true;
				}
				return false;
			}
			@Override
			public E next() {
				if (cur == null) {
					throw new NoSuchElementException();
				}
				if(cur.isEmpty()){
					throw new NoSuchElementException();
				}
				E res = cur.head();
				cur = cur.tail();
				return res;
			}
		};
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
