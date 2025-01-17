This folder contains all the features of the app, including the entities, queries, mutations, presentation (widgets), etc.

All code in this folder is to be considered "safe": they don't throw nor catch exceptions. Also, they don't make any kind of I/O, such as network requests, database access, packages that uses some sensor or native API, etc.

The reason for that is: when unit testing your project, you cannot use or depend on anything concrete (in a test, you won't have a GPS sensor, for example).
