package immutable.list.util.challenge;

import edu.wustl.cse.cosgroved.NotYetImplementedException;
import immutable.list.util.core.ImList;

import java.util.Iterator;
import java.util.NoSuchElementException;

/**
 * @author Dekang Cao
 * @author Dennis Cosgrove (http://www.cse.wustl.edu/~cosgroved/)
 */
public enum SingletonEmptyImList implements ImList<Object> {
	SINGLETON;

	@SuppressWarnings("unchecked")
	public static <T> ImList<T> getSingleton() {
		return (ImList<T>) SINGLETON;
	}

	

	private SingletonEmptyImList() {
		
			throw new NotYetImplementedException();
		
	}

	@Override
	public boolean isEmpty() {
		
			throw new NotYetImplementedException();
		
	}

	@Override
	public Object head() {
		
			throw new NotYetImplementedException();
		
	}

	@Override
	public ImList<Object> tail() {
		
			throw new NotYetImplementedException();
		
	}

	@Override
	public Iterator<Object> iterator() {
		
			throw new NotYetImplementedException();
		
	}

	@Override
	public String toString() {
		return "[]";
	}
}
