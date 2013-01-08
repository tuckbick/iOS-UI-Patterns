iOS-UI-Patterns
===============

A collection of useful iOS UI Patterns. Bear in mind that these are crude renditions and hopefully I get the point across.

## Window Panes ##

This is an implementation of view switching that mimicks Google Chrome's tab switching.


## Slide Out Nav ##

Each main window features a Nav button that reveals a navigation menu.
    
### Version 1 ###

The navigation menu is positioned relatively to the left of the content. To open, either press the Nav button or swipe to the right on the content. When revealed, the menu and content are both moved simultaneously to the right. To dismiss, either press the Nav button again, tap the content, or swipe to the left at the edge between the menu and the content.

### Version 2 ###

The navigation menu is positioned statically beneath the content. To open, either press the Nav button or swipe to the right on the content. When revealed, the menu is moved aside displaying the menu beneath. To dismiss, either press the Nav button again, tap the content, or swipe to the left at the edge between the menu and the content.

### Version 3 ###

The navigation menu is positioned statically above and off the screen to the left of the content. When revealed, the menu moves in over the content. To dismiss, swipe inside the menu to the left.
