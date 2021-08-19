# rick_morty

An app made with love and [Flutter](https://flutter.dev) by [Marchacio](https://play.google.com/store/apps/dev?id=6226476728918357054&hl=it&gl=US).



### App History

I started developing this app in July 2021 for educational purposes only and to have some fun.

In two weeks I managed to get a definitive version (it's a very simple app), and I thought I'd make it public and open-source to share my coding experience with everyone!



### App structure

The application is very simple and easy to understand.

All data are saved in an *Assets/Database/Database.db* file which, when the app starts, are loaded into the ram memory and then shown to the user quickly and without loading times.

Obviously this would make the app very heavy, but with various flutter techniques and functions I was able to save ram memory (for example by deleting images not displayed in the lists).

Other than that, under the "lib" folder I have divided the files by category:

- **API**: this is the folder that contains all the files dedicated to gathering information from the database and loading them into ram

- **CustomWidgets**: this folder contains all the widgets created by me, used several times in the app in different contexts

- **Error**: this folder contains all files that handle errors that may occur while using the app (for example when there is no internet connection)

- **Pages**: this folder contains all the graphics pages of the app. it is the heart of the graphic part and is in turn divided into different folders, ordered according to the context

- **RXDart**: This folder contains all the files dedicated to the management of the [RXDart plugin,]([rxdart | Dart Package](https://pub.dev/packages/rxdart)) thanks to which the app loads all the data in ram and manages them



### Advice and contacts

Thanks for reading so far, you can tell me what you think about my app by writing me to the work email marchacio03@gmail.com or by **contributing directly from GitHub**.



Thank you, [Marchacio](https://play.google.com/store/apps/dev?id=6226476728918357054&hl=it&gl=US).
