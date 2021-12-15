import java.applet.*;
import java.awt.*;
import java.net.*;
import java.util.*;


// classes whenever it changes.

public class ShoppingCart extends Observable
{
	protected Vector items;	// shows the total items in the cart
	protected int total;	// cart total costs so far

	public ShoppingCart()   //can get any number of items on the cart
	{
		items = new Vector();
		total = 0;
	}

// Add a new item on the cart  and update the total

	public void addItem(ShoppingCartItem newItem)
	{

// Check if there is a new item in the cart 
		int currIndex = items.indexOf(newItem);

		ShoppingCartEvent event = new ShoppingCartEvent();

		if (currIndex == -1) {
// When item is new, update the cart with it
			items.addElement(newItem);
			event.item = newItem;
			event.eventType = ShoppingCartEvent.ADDED_ITEM;
		} else {

// If item already exists, update the totals
		ShoppingCartItem currItem =
			(ShoppingCartItem) 
			items.elementAt(currIndex);

		currItem.add(newItem);
		event.item = currItem;
		event.eventType = ShoppingCartEvent.CHANGED_ITEM;
	}

	total += newItem.itemCost * newItem.quantity;

// Update the observeer class
	setChanged();
	notifyObservers(event);
	}

// Remove item from cart
 

	public void removeItem(ShoppingCartItem oldItem)
	{
// Get the item id 
	int currIndex = items.indexOf(oldItem);
	ShoppingCartEvent event = new ShoppingCartEvent();

	if (currIndex == -1) {
//If not found, proceed
		return;
	} else {
		ShoppingCartItem currItem =
				(ShoppingCartItem)
				items.elementAt(currIndex);

 

		if (oldItem.quantity > currItem.quantity) {
			oldItem.quantity = currItem.quantity;
		}

// Update the cart totals 
		total -= oldItem.itemCost * oldItem.quantity;

		currItem.subtract(oldItem);

		event.item = currItem;
		event.eventType = ShoppingCartEvent.CHANGED_ITEM;

// Check if quantity is 0 then clear cart list

		if (currItem.quantity == 0) {
			items.removeElementAt(currIndex);
			event.eventType =
				ShoppingCartEvent.REMOVED_ITEM;
		}
			
		}

// Upadte car status

	setChanged();
	notifyObservers(event);
	}

// Use getItems to return a copy of all items in the cart

	public ShoppingCartItem[] getItems()
	{
	ShoppingCartItem[] itemArray = 
		new ShoppingCartItem[items.size()];

	items.copyInto(itemArray);

	return itemArray;
	}
}