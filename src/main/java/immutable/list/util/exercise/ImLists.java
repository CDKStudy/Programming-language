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

import immutable.list.util.core.ImList;

import java.util.Iterator;
import java.util.*;

/**
 * @author Dekang Cao
 * @author Dennis Cosgrove (http://www.cse.wustl.edu/~cosgroved/)
 */
public class ImLists {
	/**
	 * Mimics the behavior of the nil constructor of the 'a list datatype in the
	 * <a href="https://smlfamily.github.io/Basis/list.html">SML List structure</a>.
	 * 
	 * @param <E> the type of elements held in the ImList
	 * @return an empty ImList
	 */
	static EmptyImList instance = EmptyImList.getInstance();//Singleton pattern
	static NonEmptyImList instance2;
		public static <E> ImList<E> nil() {
		return instance;
	}

	/**
	 * Mimics the behavior of the :: constructor of the 'a list datatype in the
	 * <a href="https://smlfamily.github.io/Basis/list.html">SML List structure</a>.
	 * 
	 * @param <E>  the type of elements held in the ImList
	 * @param head the value
	 * @param tail the rest
	 * @return the constructed list
	 */
	public static <E> ImList<E> cons(E head, ImList<E> tail) {
		   instance2 = new NonEmptyImList(head,tail);
		   return instance2;
	}

	
	/**
	 * Mimics the behavior of constructing an 'a list by enclosing elements in
	 * brackets. For example: [x, y, z].
	 * 
	 * @param <E>      the type of elements held in the ImList
	 * @param elements the contents of the to be created list
	 * @return the created list
	 */
	@SafeVarargs
	public static <E> ImList<E> brackets(E... elements) {
		if(elements == null){
			return instance;
		}else{
			Queue<E> que = new LinkedList<>();
			for(E e :elements){
				que.offer(e);
			}
			for(E e :que){
				return  cons(que.poll(),collect(que));
			}
		}
		return instance;
	}

	private static <E> ImList<E> collect(Queue<E> elements) {
		if(elements.isEmpty()){
			return instance;
		}else{
			for(E e :elements){
				return  cons(elements.poll(),collect(elements));
			}
		}
		return instance;
	}
}
