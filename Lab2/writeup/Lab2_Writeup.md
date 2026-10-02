# Lab 2: Numbers and Displays

Course: ENCE 3100 — Advanced Digital Design
Board: DE10-Lite

Note: this lab was originally written for the DE2 board, which has more switches and displays than our DE10-Lite. Because of that, Part V's second number is fixed at 45 instead of coming from switches, and the extra carry digit is shown on an LED instead of a seventh display.

---

## Part I — Switches to 7-Segment Displays

SW[3:0] and SW[7:4] are decoded directly onto HEX0 and HEX1 with the stock Seg7_Decoder module, using plain assign statements.

---

## Part II — Binary-to-BCD Conversion

I needed to convert a 4-bit binary value V (0–15) into two decimal digits d1 d0, treating V = 10–15 as "1x". A comparator flags when V is greater than 9, Circuit A derives the correction bits, and a 4-bit-wide mux selects between the raw and corrected value.

### Logic design

| Comparator (z = v3 & (v2 | v1)) | Circuit A (correction bits) |
|---|---|
| ![Comparator truth table](screenshots/part2/P2_Comp_TT.png) | ![Circuit A truth table](screenshots/part2/p2_circuitA_TT.png) |

z is 1 whenever V is greater than 9. Circuit A produces the bits needed to turn the raw binary value into the correct ones digit once z is 1.

### RTL netlists (Quartus RTL Viewer)

![Part2_Comparator netlist](screenshots/part2/p2_comp_netlist.png)
Part2_Comparator: implements z = v3 & (v2 | v1) directly in gates.

![Part2_CircuitA netlist](screenshots/part2/p2_circA_netlist.png)
Part2_CircuitA: the correction logic, built from the Boolean equations derived from the truth table above.

![mux_2_1 netlist](screenshots/part2/p2_mux2_1_netlist.png)
One bit-slice of the 4-bit-wide mux (Part2_Mux4) used to select between the raw value and Circuit A's corrected value based on z.

![Part2_BinToBCD top-level netlist](screenshots/part2/p2_binbcd_netlist.png)
Full Part2_BinToBCD module: comparator, Circuit A, and the 4-bit mux wired together, matching Figure 1 of the handout (minus Circuit B and the decoder, per the Part II spec).

### Simulation (Logisim)

![Circuit B simulation](screenshots/part2/p2_circB.png)
Circuit B: converts the z flag into the correct 7-segment pattern for the tens digit, blank when z is 0, "1" when z is 1.

![Seg7 decoder simulation](screenshots/part2/p2_seg7.png)
Tens-digit segment pattern check, confirming z = 1 lights only the two segments needed to draw a "1".

![Seg7 decoder RTL](screenshots/part2/p2_seg7_netlist.png)
Seg7_Decoder gate-level netlist, the 7 Boolean equations for a through g, generated from assign statements rather than a case statement.

### Full Part II top-level (switches to HEX2/HEX3)

![Part2 main circuit](screenshots/part2/p2_main_circ.png)
main.v's Part II section: SW[3:0] goes into Part2_BinToBCD, which drives the ones digit on HEX2 through Seg7_Decoder and the tens digit (0 or 1) on HEX3 through Circuit B.

![Part2_Top netlist](screenshots/part2/p2_topview_netlist.png)
Standalone Part2_Top RTL view, compiled and downloaded on its own for board testing.

### Board verification

![V = 3 gives 03](screenshots/part2/p2_1.jpg)
SW[3:0] = 0011 (3) displays 03.

![V = 15 gives 15](screenshots/part2/p2_2.jpg)
SW[3:0] = 1111 (15) displays 15, confirming the correction path works for values over 9.

---

## Part III — Ripple-Carry Adder

Next, I needed to build a 4-bit adder out of four 1-bit full adders, each computing s = a XOR b XOR ci and co = ab + ci(a XOR b), with carries rippling from FA0 to FA3.

![Full adder truth table](screenshots/part3/p3_FA_TT.png)
Full adder truth table.

![FullAdder simulation](screenshots/part3/p3_full_adder.png)
Logisim model of one FullAdder instance, sum via an XOR chain, carry via a mux reduction.

![FullAdder RTL netlist](screenshots/part3/p3_FA_netlist.png)
Gate-level view of the Verilog FullAdder module, two XORs for s and an AND/AND/OR for co, matching Figure 2 of the handout.

![4-bit ripple-carry adder netlist](screenshots/part3/p3_ripple_netlist.png)
Part3_Top: four FullAdder instances chained so each stage's co feeds the next stage's ci, with LEDR[8:6] mirroring the control switches and LEDR[5]/LEDR[4] showing the overflow and carry-out flags.

![4-bit ripple adder simulation with overflow light](screenshots/part3/p3_4bit_ripple.png)
Full simulation of all four full adders plus an over indicator, which lights up exactly when the 4-bit result exceeds 9, previewing the comparator logic Part IV reuses.

![Overflow indicator on the board](screenshots/part3/p3_over10_light.png)
Board test: an input combination that pushes the sum above 9, lighting the overflow LED.

---

## Part IV — Single-Digit BCD Adder

After making the ripple carry, I need to add two BCD digits, A + B + cin (max 9+9+1=19), and re-encode the result as a valid two-digit BCD value S1S0. This directly reuses Part III's adder and Part II's comparator/mux pattern, just applied to a 5-bit raw sum instead of a 4-bit switch value.

![Part4_BCDAdder RTL netlist](screenshots/part4/p4_adder_netlist.png)
Part4_BCDAdder: four FullAdders produce the raw 5-bit sum (raw_co, sum[3:0]), Part4_Comparator flags when that raw sum is above 9, Part4_CircuitA computes the plus-6 correction, and the reused Part2_Mux4 selects between the raw and corrected sum.

![Part4_Comparator simulation](screenshots/part4/p4_comp.png)
z = co | (s3 & (s2|s1)), the same shape as Part2_Comparator, extended with the extra carry bit since the raw sum can now reach 19, not just 15.

![Part4_CircuitA simulation](screenshots/part4/p4_minus10.png)
Correction bits that turn the raw binary sum into the next BCD digit once it exceeds 9.

![Part4_Top full netlist](screenshots/part4/p4_top_netlist.png)
Part4_Top: SW[7:4] is A, SW[3:0] is B, SW[8] is cin. A and B's validity is checked with two more Part2_Comparator instances, lighting LEDR[9] on invalid BCD input. A, B, and the BCD sum digits are decoded onto HEX5, HEX4, HEX1, and HEX0.

### Board verification

![A=01 B=01 cin=1 gives sum 02](screenshots/part4/p4.jpg)
HEX5/HEX4 = 01 (A, B), HEX1/HEX0 = 02 (sum digits): 0+1+1=2.

![A=00 B=07 cin=1 gives sum 08](screenshots/part4/p4_2.jpg)
HEX5/HEX4 = 07, HEX1/HEX0 = 08: 0+7+1=8, confirming correct addition without triggering the BCD correction path since the sum stays at or below 9.

---

## Part V — Two-Digit BCD Adder

Finally, I chained two Part IV single-digit BCD adders, with the low digit's cout feeding the high digit's cin, to add two 2-digit BCD numbers and produce a 3-digit BCD sum S2S1S0. This is the same ripple-carry idea as Part III, just one level up: instead of chaining 1-bit full adders, we chain 1-digit BCD adders.

As noted above, B1B0 is fixed at 45 on this board instead of being switch-driven. A1A0 comes from SW[7:0], and the extra sum digit S2 is shown on LEDR[9].

![Part5_Top RTL netlist](screenshots/part5/p5_top_netlist.png)
Two Part4_BCDAdder instances: ADD0 computes A0 + 5 + 0, ADD1 computes A1 + 4 + ADD0's cout. A1A0 is decoded onto HEX5/HEX4, the fixed B1B0=45 onto HEX3/HEX2, and the sum S1S0 onto HEX1/HEX0.

![Single-digit BCD adder datapath simulation](screenshots/part5/p5_top.png)
Functional simulation of the underlying single-digit BCD adder datapath (ripple_adder, then minus10 correction, then mux), the same building block instantiated twice to form the Part V two-digit adder.

### Board verification

![Part V test 1](screenshots/part5/p5_1.jpg)
![Part V test 2](screenshots/part5/p5_2.jpg)
![Part V test 3](screenshots/part5/p5_3.jpg)
![Part V test 4](screenshots/part5/p5_4.jpg)

Four switch settings for A1A0 tested against the fixed B1B0 = 45, with the resulting sum read across HEX5 through HEX0, and the extra sum digit on LEDR[9] when the total carries into a third digit. Exact digit values above should be double-checked against the live board, since these photos were taken at an angle.

---

## Summary

| Part | Module(s) | Reuses |
|---|---|---|
| II | Part2_Comparator, Part2_CircuitA, Part2_Mux4, Part2_BinToBCD, Part2_CircuitB | — |
| III | FullAdder, Part3_Top (ripple-carry chain) | — |
| IV | Part4_Comparator, Part4_CircuitA, Part4_BCDAdder | FullAdder (III), Part2_Mux4, Part2_Comparator (II) |
| V | Part5_Top | Part4_BCDAdder x2 (IV) |

Each part builds on the previous one's verified modules instead of re-deriving logic from scratch. The comparator/correction/mux pattern from Part II reappears unchanged in Part IV, and the bit-level ripple-carry idea from Part III reappears as digit-level ripple-carry in Part V.
