iOS-UI-Patterns
===============

A collection of useful iOS UI Patterns. Bear in mind that these are crude renditions and hopefully you get the idea.

## Window Panes ##

This is an implementation of view switching that mimicks Google Chrome's tab switching.


## Slide Out Nav ##

Each main window features a Nav button that reveals a navigation menu.
    
### Version 1 (Pan) ###

The navigation menu is positioned relatively to the left of the content. To open, either press the Nav button or swipe to the right on the content. When revealed, the menu and content are both moved simultaneously to the right. To dismiss, either press the Nav button again, tap the content, or swipe to the left at the edge between the menu and the content.

### Version 2 (Reveal) ###

The navigation menu is positioned statically beneath the content. To open, either press the Nav button or swipe to the right on the content. When revealed, the menu is moved aside displaying the menu beneath. To dismiss, either press the Nav button again, tap the content, or swipe to the left at the edge between the menu and the content.

### Version 3 (Appear) ###

The navigation menu is positioned statically above and off the screen to the left of the content. When revealed, the menu moves in over the content. To dismiss, swipe inside the menu to the left.

### Version 4 (Fold) ###

The navigation menu is 'folded' to the left of the content. To open, press the Search button. The menu will be 'unfolded' to reveal itself and move the content aside. To dismiss, press the Nav button again or tap the content.
