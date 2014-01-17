This app demonstrates what happens if you re-push a page already on the pageStack.

Sailfish allows this to happen. A second instance of the page being pushed is added to the stack (and thus the number of pages on the stack can grow)


The real problem (and the reason that my app did this) is that what I need to do is pass information back to the previous page on the stack.
In effect just as one can push a page passing parameters, I would like to be able to pop back with params!


In the demo SecondPage has 2 buttons.
1) demos the "re-push" approach. the more you do this, the greater the number of pages on the stack as shown by the breadcrumbs.

2) demos an approach where before calling the pop method I directly change the property of the previous page using a param from the BackPage signal defined on SecondPage

Not both FirstPage and SecondPage are child elements of PageHandling.qml, and all the Push() and Pop() calls are PageHandling.qml
