This project demonstrates use of Jsonpath to query a simple datamodel.

The original idea was ot use json as a way of loading a LocalStorageDB. The file would be created on a Qt Desktop app, then used to load my app Landed on the Jolla Sailfish.

Then I discovered this:

http://goessner.net/articles/JsonPath/
https://code.google.com/p/jsonpath/
https://github.com/kromain/qml-utils

And this got me thinking: My data model is simple, four tables with a few handfuls of records each. Simple enought to be able query directly.

As all my SQLs are centralised in a javascript file (rather than being spread across all my QML files), if jsonpath can return a similar structure to that returned from LocalStorage, then it should be possible to swap in a json db inplace of the LocalStorage.

The demo uses just two entities: Areas, and Templates. Templates are childs of Areas.

On the FirstPage.qml are 2 ListViews:

The first lists all areas: This works -->OK

The second should list just the templates that are the childs of one of the areas: At the moment however it lists all templates: --> NotOk

It is possible that my query is incorrectly formed, or that jsonpath has a bug. I am investigating .....

Note you will need to manually deploy the json file to the Jolla device / Sailfish Emulator

/home/nemo/Documents/JsonDBDemo/landeddb.json

How does it work?
a) the file is opend by a C++ for QML/JS plugin jsonstorage.h/cpp. At the moment all this does is open the file, but in the future I might push the json processing into this plugin.
b) JSONStorage plugin is imported to readDataModel.js. This file contains the queries: in the current version of my app Landed these are SQLs accessing a LocalStorageDB, here they will be jsonpath
c) readDataModel.js also converts the output of jsonpath to LocalStorage type structures, which can then be processsed by my QML in the same way that my QML currently handles SQL recordsets.
d) the actual json query magic happens in jsonpath.js.

