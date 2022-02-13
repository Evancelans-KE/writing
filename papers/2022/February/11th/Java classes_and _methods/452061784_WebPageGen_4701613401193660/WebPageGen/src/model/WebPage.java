package model;

import java.util.*;

/**
 * Represents a web page.  Web page elements are
 * stored in an ArrayList of Element objects.  A title
 * is associated with every page.  This class implements
 * the Comparable interface.  Pages will be compared
 * based on the title.
 * @author UMCP
 *
 */
public class WebPage implements Comparable<WebPage> {
	private ArrayList<Element> elements;
	private String title;

}
