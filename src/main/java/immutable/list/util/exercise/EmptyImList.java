package immutable.list.util.exercise;

import edu.wustl.cse.cosgroved.NotYetImplementedException;
import immutable.list.util.core.ImList;

import java.util.Iterator;
import java.util.NoSuchElementException;

/**
 * @author Dekang Cao
 * @author Dennis Cosgrove (http://www.cse.wustl.edu/~cosgroved/)
 */
/* package-private */ class EmptyImList<E> implements ImList<E> {

	private static EmptyImList instance = new EmptyImList();
	/* package-private */ EmptyImList() {
		
			//throw new NotYetImplementedException();
		
	}
	public static EmptyImList getInstance(){
		return instance;
	}

	@Override
	public boolean isEmpty() {

		return true;
		
	}

	@Override
	public E head() {

		throw new NoSuchElementException();
		
	}

	@Override
	public ImList<E> tail() {

		throw new NoSuchElementException();
		
	}

	@Override
	public Iterator<E> iterator() {

		 return null;
		
	}

	@Override
	public String toString() {
		return "[]";
	}

	@Override
	public boolean equals(Object obj) {
		if(obj instanceof ImList) {
			ImList<?> other = (ImList<?>) obj;
			return other.isEmpty();
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return 0;
	}
}
