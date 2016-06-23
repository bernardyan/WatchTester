# WatchTester
Because current watchOS doesn't support CoreBluetooth framework, there is no way to determine the distance between an apple watch and an iPhone by reading RSSI value.

In WatchTester, I tried to achieve the same distance measuring effect by a work around. It all based on a simple assumption: The greater the distance, the worse the network between two devices get.

The code works as follows: When the user opens the watch app, the app sends a packet with current time to the iPhone. When the iPhone receives the packet, it calculate the time difference between it gets the packet and the time the packet is generated.

Although the estimation is not as accurate as measuring the RSSI value, it gives an idea of how far away these devices are. And by keeping record of an array of time difference data, it is possible to cancel the noise and get a range of estimation of the separation. That is enough for making a distance indicator.
