# qbEVK
A modular robotics experiment utilising affordable off-the-shelf components and 3D printing.

## Components

### qbNODE
A 3D printed frame measuring approximately 65x65x60mm holding 4 qbEDGE PCBs, a power supply module and a communications module.

![Exported CAD of RevA qbNODE, excluding power and comms modules](https://github.com/peterwallhead/qbEVK/blob/master/components/qbNODE/RevA/cad/exports/qbNODE-RevA.png)

### qbEDGE (RevA in development)
A PCB with its own dedicated ESP32 and power regulation circuit (max power input of 15VDC) which shares a common power rail and RS485 bus with all the edges in the same node. Each edge can be linked to another node using a 5-way spring connector (GND, RS485A, RS485B, I/O, I/O).

![qbEDGE RevA PCB - inside](https://github.com/peterwallhead/qbEVK/blob/master/components/qbEDGE/RevA/pcb/exports/inside.png)
![qbEDGE RevA PCB - outside](https://github.com/peterwallhead/qbEVK/blob/master/components/qbEDGE/RevA/pcb/exports/outside.png)

### qbPOWER (Coming soon)
An optional power module mounted in the base of a qbNODE to provide 6-12VDC to each qbEDGE.

### qbCOMMS (Coming soon)
An optional communications module mounted to the top of a qbNODE to interface with the RS485 bus via Serial using an XBee, or other wireless, module.

## Component compatibility
component | compatible with
------------ | -------------
qbNODE RevA | qbEDGE RevA, qbPOWER RevA, qbCOMMS RevA
qbEDGE RevA | qbPOWER RevA, qbCOMMS RevA

## Serial number naming convention
project | component name | revision letter | major.minor.patch numbering (optional) | last revision date
------------ | ------------- | ------------- | ------------- |  -------------
qbEVK | EDGE | A | 1.0.0 | 20211003

***Example:***
```qbEVK-EDGE-A-1.0.0-20211003```

## qbNETWORK
A network comprising of multiple qbNODEs connected together on the same RS485 bus.
