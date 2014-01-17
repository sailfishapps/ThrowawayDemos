import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow
{

    initialPage: firstPage

    FirstPage {
        id: firstPage
        onNextPage: {
            pageStack.push(secondPage)
        }
    }
    SecondPage {
        id: secondPage
        onNextPage: {
            //I think this is the problem: Page is being repushed to pass params!
            //the BackPage method below is better
            pageStack.push(firstPage, {importantParam: true})
        }
        onBackPage: {
            firstPage.importantParam = importantParam;
            pageStack.pop(firstPage);
        }
    }
}


