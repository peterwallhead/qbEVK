**While the qbEDGE boards were designed to be assembled into qbNODES, you can also use them as standalone ESP32 IO boards running your own code.**

To avoid damaging your ESP32, or other components, please take careful note of the following information during development.

## Pins used
IO | Connected to | Notes
------------ | ------------- | -------------
EN | RESET | Used to reset the board after programming. Pulled to ground when RESET jumper points are bridged
IO0 | BOOT | Used to enable boot mode for programming. Pulled to ground when BOOT header is bridged
TXD0/IO01 | RX on TTL PROG | Used for programming and serial monitoring
RXD0/IO03 | TX on TTL PROG | Used for programming and serial monitoring
IO16 | RO on MAX3485 (U2) | Software Serial RX pin
IO17 | DI on MAX3485 (U2) | Software Serial TX pin
IO18 | RE & DE on MAX3485 (U2) | Serial communication control pin
IO04 | S1 (FUNC) | Pulled to ground (LOW) when FUNC button is pressed
IO13 | D1 | Green LED (Pull HIGH to light LED)
IO21 | D2 | Red LED (Pull HIGH to light LED)
IO26 | Pin 4 on J1 | Read from left to right. Best used as an output pin. Writes to pin 2 on J2 of a connected qbEDGE
IO25 | Pin 5 on J1 | Read from left to right. Best used as an output pin. Writes to pin 1 on J2 of a connected qbEDGE
IO23 | Pin 1 on J2 | Read from left to right. Best used as an input pin. Reads from pin 5 on J1 of a connected qbEDGE
IO22 | Pin 2 on J2 | Read from left to right. Best used as an input pin. Reads from Pin 4 on J1 of a connected qbEDGE

## Programming quick start

### Parts required
- Assembled qbEDGE board
- 5V compatible USB to TTL converter cable with female jumper ends
- Spare jumper leads
- Optional 2 way jumper cap

### Flash board
*Note: Due to the tight space within an assembled qbNODE, it might be easier to flash your qbEDGEs before final assembly.*

1. Ensure board is not connected to any power source.
2. Connect USB to TTL cable from your computer to the board (RX, TX, GND, VIN).
3. Ensure you can see the board connected to your computer's COM port.
4. Use a jumper cap, or a female to female jumper lead, to bridge the BOOT header.
5. Using a small piece of wire, or a male to male jumper lead, bridge and then release the RESET jumper points on the board to enter programming mode.
6. Flash the board using your preferred IDE or tool chain.
7. Remove the bridge from the BOOT header.
8. Using a small piece of wire, or a male to male jumper lead, bridge and then release the RESET jumper points on the board to exit programming mode.
