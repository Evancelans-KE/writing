package model;

import java.util.ArrayList;

/**
 * 
 * Represents a paragraph (&lt;p&gt;) tag.  It relies on an
 * ArrayList in order to keep track of the set of Element objects
 * that are part of the paragraph.
 * @author UMCP
 *
 */
public class ParagraphElement extends TagElement {
	private ArrayList<Element> items;
	
}
