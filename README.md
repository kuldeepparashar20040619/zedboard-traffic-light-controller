# Traffic Light Controller with Pedestrian Crossing (Zedboard)

Verilog implementation of a traffic light controller for an intersection (North-South and East-West) with pedestrian crossing on a Zedboard (Zynq-7000).

## Overview
The controller cycles through normal traffic phases (Green -> Yellow -> Red) for both directions. When the pedestrian push button is pressed, the request is latched and the system brings both vehicle lanes to Red before enabling the Walk signal. After the walk period finishes, the system resets the request and resumes the vehicle sequence.

## Files
- `top_module.v`: Top-level wrapper mapping logic to Zedboard I/O.
- `traffic_fsm.v`: FSM handling traffic states and pedestrian requests.
- `clk_divider.v`: Generates delay timing from the 100 MHz oscillator.
- `output_logic.v`: Decodes FSM states into LED outputs.
- `traffic_xdc.xdc`: Zedboard pin mapping and I/O constraints.

## States
- `S_NS_G`: North-South Green, East-West Red
- `S_NS_Y`: North-South Yellow, East-West Red
- `S_EW_G`: North-South Red, East-West Green
- `S_EW_Y`: North-South Red, East-West Yellow
- `S_P_SETUP`: All Red (clearance interval)
- `S_P_WALK`: All Red, Pedestrian Walk active

## Board Pinout (Zedboard)
- 100 MHz Clock: `Y9`
- Reset Button (BTNC): `P16`
- Pedestrian Button (BTND): `R16`
- NS Red / Yellow / Green: `T22` (LD0), `T21` (LD1), `U22` (LD2)
- EW Red / Yellow / Green: `U21` (LD3), `V22` (LD4), `W22` (LD5)
- Walk / Don't Walk: `U19` (LD6), `U14` (LD7)

## Tools
- Board: Digilent Zedboard (xc7z020clg484-1)
- Software: Vivado
- Language: Verilog
