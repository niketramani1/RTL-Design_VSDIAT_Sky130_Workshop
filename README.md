# RTL-Design using Verilog with Sky130 Technology

## **Day 1**: Introduction to Verilog RTL Design and Synthesis

Lab 1: Setting up the environment. CLoning the repositeries from github. 
 ![image](https://user-images.githubusercontent.com/86380243/123160881-b84b4900-d43c-11eb-82af-82d80ea0e6ee.png)
 
Lab 2: Using iverilog and gtk wave to implement good_mux.v
![image](https://user-images.githubusercontent.com/86380243/123161946-090f7180-d43e-11eb-829c-8ddff59dd943.png)

Lab3: Synthesis using Yosys for good_mux.v
![image](https://user-images.githubusercontent.com/86380243/123162359-8509b980-d43e-11eb-9fbc-f83a20d21a18.png)

Writing verilog netlist
![image](https://user-images.githubusercontent.com/86380243/123163025-432d4300-d43f-11eb-83d7-a06d2e7a2ff0.png)


## **Day 2**: Timing libs, hierarchical vs flat synthesis and efficient flop coding styles

Lab1: Understanding the .lib files and the content in it. Concepts of PVT
![image](https://user-images.githubusercontent.com/86380243/123167880-2b58bd80-d445-11eb-8a9c-2c4840c4d42e.png)

Lab2: Differentiating Hierarchichal vs Flat synthesis
In hierarchical synthesis, all the modules (the top and sub modules are preserved).
Running the synthesis for multiple modules hierarchichal
![image](https://user-images.githubusercontent.com/86380243/123172932-dbc9c000-d44b-11eb-8a2b-5381a14bacf8.png)
As we can see the modules are preserved
After write_verilog we get this hierarchical netlist
![image](https://user-images.githubusercontent.com/86380243/123173621-e173d580-d44c-11eb-9855-d317ceacdcec.png)

![image](https://user-images.githubusercontent.com/86380243/123173526-bc7f6280-d44c-11eb-958f-66d1400a45fa.png)

Running the synthesis for multiple modules flat, it is a single netlist and submodules are not preserved
![image](https://user-images.githubusercontent.com/86380243/123174326-eedd8f80-d44d-11eb-88a9-6f343a180a9c.png)
After write_verilog we get this hierarchical netlist
![image](https://user-images.githubusercontent.com/86380243/123173992-724ab100-d44d-11eb-99ba-4f8f461dfba9.png)

# Synthesizing only one particular submodule from multiple modules:

After synthesizing submodule1 from multiple_modules.v we get
![image](https://user-images.githubusercontent.com/86380243/123176274-2568d980-d451-11eb-8f3d-69d2d540823a.png)
As we can see only the AND gate(submodule 1) is synthesized

We do module level synthesis primarily for 2 reasons:
a) If same module instantiated multiple times in design, we need not synthesize it multiple times. Rather, we do it once and stitch them together
b) If it is a large design with many number of modules, we do the synthesis part by part basically divide and conquer

FLIP FLOPS AND THEIR SIMULATIONS AND SYNTHESIS
Why a flip flop?
Is basically used to avoid glitches when there is a series of combinational circuits.
A flip flop has to have an initial state or else the comb circuits might get some garbage values.
This can be done using the set/ reset. The set/reset can be synchronous or asynchronous. In some cases, the FF can have both synchronous and asynchronous reset at the same time.
Asynchronous is basically independent of clock and synchronous is dependent on the clock.

**SIMULATIONS**:

1)Aynchronous reset:

![image](https://user-images.githubusercontent.com/86380243/123180948-54d01400-d45a-11eb-8f5c-90ff127c6881.png)
![image](https://user-images.githubusercontent.com/86380243/123181231-e5a6ef80-d45a-11eb-826f-a6a6f9fe8a27.png)

2)Asynchronous set:

![image](https://user-images.githubusercontent.com/86380243/123181822-16d3ef80-d45c-11eb-8ceb-85d4fa368295.png)

3)Synchronous reset:

![image](https://user-images.githubusercontent.com/86380243/123182148-d2951f00-d45c-11eb-8031-33c2f66f7643.png)

**SYNTHESIS**:

1)Asynchronous reset:

![image](https://user-images.githubusercontent.com/86380243/123182792-27856500-d45e-11eb-9416-de8ba927ddcf.png)
Here there is an inverter because the dff in library is active low and we have designed an active high reset

2)Asynchronous set:

![image](https://user-images.githubusercontent.com/86380243/123183135-e3469480-d45e-11eb-80bb-d3832bc1c49e.png)

3)Synchronous reset:

![image](https://user-images.githubusercontent.com/86380243/123183304-49331c00-d45f-11eb-80b7-f2384a7eb7a3.png)

Optimizations in synthesis
Synthesizing mult_2: We can see there is no hardware as its only appending a 0
Multiplication in binary is basically shifting
![image](https://user-images.githubusercontent.com/86380243/123184415-a7f99500-d461-11eb-9ac7-68bc44b996ae.png)
The netlist will be:
![image](https://user-images.githubusercontent.com/86380243/123184799-6d442c80-d462-11eb-8aff-3b52a1fddc7e.png)

Synthesizing mult_8: We can see there is no hardware as its appending
![image](https://user-images.githubusercontent.com/86380243/123185041-0b37f700-d463-11eb-8bd1-b038a8acb95e.png)
The netlist will be: 
![image](https://user-images.githubusercontent.com/86380243/123185161-45a19400-d463-11eb-89b0-0d330087a794.png)
As we can see, its basically concatenating {a,a}


## **Day 3**: Combinational and sequential optimizations

Combinational optimizations can be done in below ways (the tool optimizes):
1) Squeezing the logic for optimized design (PPA)
2) Constant propagation (Direct optimization)
   Example can be if an input to a particular circuit is 0 and this 0 propagates to the primary output resulting in a constant value, the hardware is basically redundant.
3) Boolean optimizations
   Example can be a Multiple mux implementation which finally leads to a simple gate after Boolean optimization

Sequential optimizations can be done in below ways:
1) Basic: Sequential constant propagation
   Assume that a D flop's input is always 0(GND) and we also have a reset pin connected. THe Q output is never going to be 1(VDD) and if Q is going to a 2 inut NAND gate, the      output of it is always going to be 1
2) Advanced : 

   a) State optimizations: Unused state can be optimized
   
   b) Retiming: Retiming of combinational logic in a flop to flop path can lead to a better max frequency
   
   c) Cloning: Physical aware optimization
   
   Lab 06: For combinational optimization, we use all opt_check labs
   
   1)Synthesizing opt_check1.v which is an actual 2:1 Mux, it optimizes to a 2 input AND gate. We make us of opt_clean -purge here.
   
   ![image](https://user-images.githubusercontent.com/86380243/123327348-522bf800-d508-11eb-8b3a-a362ba1230bc.png)
   ![image](https://user-images.githubusercontent.com/86380243/123327160-1bee7880-d508-11eb-99e3-ad14ad65a8ee.png)
   As we can see above y=a.0 + a.b optimizes to a.b (AND)
   
   2)Synthesizing opt_check2.v which is an actual 2:1 Mux, it optimizes to a 2 input OR gate. We make us of opt_clean -purge here.
   
   ![image](https://user-images.githubusercontent.com/86380243/123328785-024e3080-d50a-11eb-8e49-ee3805f15716.png)
   ![image](https://user-images.githubusercontent.com/86380243/123328732-ee0a3380-d509-11eb-9dbb-a8eacb93ee1b.png)
   As we can see above y=a'b + a.1 optimizes to a+b (OR)
   
   3)Synthesizing opt_check3.v which actually two instances of 2:1 Mux, it optimizes to a 3 input AND gate. We make us of opt_clean -purge here.
   
   ![image](https://user-images.githubusercontent.com/86380243/123330510-1c890e00-d50c-11eb-992d-95fbef43255a.png)
   ![image](https://user-images.githubusercontent.com/86380243/123330591-362a5580-d50c-11eb-9704-d946193f7acb.png)
   As we can see above y=a.(b.c + c'.0) optimizes to a.b.c (AND)
   
   4)Synthesizing opt_check4.v which actually two instances of 2:1 Mux, it optimizes to a 2 input XNOR gate.
   
   ![image](https://user-images.githubusercontent.com/86380243/123331122-da140100-d50c-11eb-8434-707485af0598.png)
   ![image](https://user-images.githubusercontent.com/86380243/123331365-34ad5d00-d50d-11eb-9448-aa935a5b3528.png)
   As we can see above y=a.c' + a(b'.c + a.b.c) optimizes to a'b' + ab (XNOR)
   
   5)Synthesizing multiple_modules_opt.v, and flattening the netlist
   
   ![image](https://user-images.githubusercontent.com/86380243/123332062-067c4d00-d50e-11eb-8f8b-cc9dacf8d315.png)
   ![image](https://user-images.githubusercontent.com/86380243/123332595-afc34300-d50e-11eb-9920-82b0edcdb1b2.png)
   As we can see, that the multiple module implementations are optimized to AND OR INVERT21 (AOI21)
   
   5)Synthesizing multiple_modules_opt2.v, and flattening the netlist
   
   ![image](https://user-images.githubusercontent.com/86380243/123333869-49d7bb00-d510-11eb-9722-613f5b997ccd.png)
   ![image](https://user-images.githubusercontent.com/86380243/123333789-32003700-d510-11eb-9c62-a03986679788.png)
   As we can see, that the multiple module implementations are optimized to a simple logic

  # Lab 07: For combinational optimization, we use all dff_const labs
   
   1a)Simulating dff_const1.v, we see that a flop has to be inferred as even if it is async reset. The o/p will change only on next edge of clock.
   
   ![image](https://user-images.githubusercontent.com/86380243/123336779-52ca8b80-d514-11eb-9a7b-8187808ec127.png)
   
   1b)Synthesizing dff_const1.v, we see that the FF instance is still there
   
   ![image](https://user-images.githubusercontent.com/86380243/123337677-940f6b00-d515-11eb-97c7-a481611499c4.png)

   
   2a)Simulating dff_const2.v, we see that q always remains high irrespective of reset
   
   ![image](https://user-images.githubusercontent.com/86380243/123337097-be145d80-d514-11eb-8b44-326b9cd7e02f.png)
   
   2b)Synthesizing dff_const2.v, we see that the FF instance is not there
   
   ![image](https://user-images.githubusercontent.com/86380243/123338064-39c2da00-d516-11eb-916a-f396ac174e23.png)
   ![image](https://user-images.githubusercontent.com/86380243/123338185-60811080-d516-11eb-9b04-574718899ee3.png)
   We can see it from the netlist as well
   
   3a)Simulating dff_const3.v, we see that the q goes low initially because of the flop 1 clq->q delay and then goes high on the next posedge of clk
   
   ![image](https://user-images.githubusercontent.com/86380243/123344977-076ba980-d523-11eb-9709-acaa4c30f533.png)
   
   3b)Synthesizing dff_const3.v, we see that both the FF instance are still there
   
   ![image](https://user-images.githubusercontent.com/86380243/123345113-5addf780-d523-11eb-8aac-c432e88dc1f6.png)
   ![image](https://user-images.githubusercontent.com/86380243/123352156-b6f94980-d52c-11eb-9917-ca120824ff59.png)


   4a)Simulating dff_const4.v, we see that the q goes high irrespective of the set signal and there will be no optimization done as its always high
   
   ![image](https://user-images.githubusercontent.com/86380243/123350630-5ddbe680-d529-11eb-9ad2-7c6aa7981431.png)
   
   4b)Synthesizing dff_const4.v, there are no flip flops mapped and optimization is done
   
   ![image](https://user-images.githubusercontent.com/86380243/123350823-c62ac800-d529-11eb-9379-6828a7862524.png)
   ![image](https://user-images.githubusercontent.com/86380243/123350910-f83c2a00-d529-11eb-8f41-f580ca27682e.png)
   We can see that the optimized netlist has no flip flops.
   
   5a)Simulating dff_const5.v, we see that the q goes high on the next clock edge because of the flop 1 clq->q delay.
   
   ![image](https://user-images.githubusercontent.com/86380243/123351338-e27b3480-d52a-11eb-93b2-71a0c13f0757.png)
   
   5b)Synthesizing dff_const3.v, we see that both the FF instance are still there
   
   ![image](https://user-images.githubusercontent.com/86380243/123351455-1d7d6800-d52b-11eb-9cd8-72a5aa9477f7.png)
   ![image](https://user-images.githubusercontent.com/86380243/123351586-6fbe8900-d52b-11eb-80b7-043be9145246.png)
   
   
   # **Sequential Optimizations for unused outputs**
   After synthesizing counter_opt.v, we see that the first two MSB bits of q are not considered as the q is assigned only to q[0].
   
   ![image](https://user-images.githubusercontent.com/86380243/123353234-10627800-d52f-11eb-8342-c9f2ad0ded06.png)
   The circuit is basiccaly just toggling continuously between 0 and 1.
   
   Modifying the output to q[2:0] == 3'b100. This means we are using all 3 bits of counter. New file is counter_opt_modify.v
   
   ![image](https://user-images.githubusercontent.com/86380243/123354151-09d50000-d531-11eb-8e35-7c81f68275a7.png)
   
   As we can see below from the report, three flops are inferred as expected
   
   ![image](https://user-images.githubusercontent.com/86380243/123354214-2d984600-d531-11eb-81c5-46ca8ee7c716.png)
   ![image](https://user-images.githubusercontent.com/86380243/123354418-9a134500-d531-11eb-991c-bb43e4f28a02.png)
   Three flops can be seen in the netlist and hence are preserved.
   
   
   ## **Day 4**: GLS, Blocking vs non blocking statements and Synthesis simulation mismatch
   
   ### GLS: Gate level Simulation
   GLS is basically cheching the netlist generated by the synthesis tool for its timing and functionality. 
   
   This can be checked using the same testbench which we used for our RTL design and using the GLS verlilog module along with our design given to the iVerilog tool.
   
   Why validate the functionality?
   
   Its basically done to check for Synthesis and simulation mismatch. It includes:
   
   a) Missing sensitivity list
   
   Sensitivity list should contain the inputs required to drive the outputs. If an input is missing in the sensitivity list, the output might not be driven if the input changes    inside the always block.
  
   b)Blocking vs non-blocking
   
   Blocking statements are denoted with '= ' in an always block and execute in order like a C program.
   
   For a non-blocking statement '<=' , RHS is always evaluated first parallely and then assigned to the LHS. ALWAYS USE NON BLOCKING FOR A SEQUENTIAL CIRCUIT.
   
   c)Non standard verilog coding.
   
   
  # Lab on GLS Synthesis Simulation mismatch
  
  1a) Simulating the ternary_operator_mux.v
  
  ![image](https://user-images.githubusercontent.com/86380243/123528587-6281d580-d6b6-11eb-806b-7e9081312527.png)

  
  As we can see above its clearly working as a 2:1 MUX.
  
  1b) Synthesizing the ternary_operator_mux.v, clearly its a MUX in the report
  
  ![image](https://user-images.githubusercontent.com/86380243/123465732-7ea14c00-d5bc-11eb-8098-1d8100b98c87.png)
  
  ![image](https://user-images.githubusercontent.com/86380243/123465899-b4463500-d5bc-11eb-800b-30d5150d04a6.png)
  
  1c) GLS output is same as simulation output
  
  ![image](https://user-images.githubusercontent.com/86380243/123479108-69351d80-d5ce-11eb-95b8-275d533376d8.png)

  
  2a) Simulating the bad_mux.v
  
  ![image](https://user-images.githubusercontent.com/86380243/123479641-3b9ca400-d5cf-11eb-81c7-b042012e611e.png)
 
  As we can see above, the Mux functionality is not implemented because the activity is only dependent on sel and not i0 and i1.
  
  2b) Synthesizing the bad_mux.v, clearly its a MUX in the report. That means he synthesis tool considers it a mux behaviour and independent of the sensitivity list.
  
  ![image](https://user-images.githubusercontent.com/86380243/123480310-296f3580-d5d0-11eb-8a94-6ef781f62f8c.png)
  
  2c) GLS output is not same as simulation output. It can be clearly seen that it is a 2:1 Mux implementation
  
  ![image](https://user-images.githubusercontent.com/86380243/123480653-a8646e00-d5d0-11eb-9572-e590ad5bd965.png)
  
  Hence, this is a problem of Synthesis simulation mismatch which we need to take care.
  
  
  3a) Simulating the blocking_caveat.v
  
  ![image](https://user-images.githubusercontent.com/86380243/123482057-a4395000-d5d2-11eb-9203-53e5c77c3d00.png)
   
  As seen above, clearly a flop is inferred and previous values of a & b are anded with current value of c as the code runs in a sequential order. This is not what we want.
  
  3b) Synthesizing the blocking_caveat.v, we get a correct behaviour of an OA21 gate aget mapping with the standard cell library.
  
  ![image](https://user-images.githubusercontent.com/86380243/123482749-b1a30a00-d5d3-11eb-8a53-0f4901adf886.png)
 
  3c) GLS output is not same as simulation output. It can be clearly seen that we get the required output in GLS simulation.
  
  ![image](https://user-images.githubusercontent.com/86380243/123483516-d5b31b00-d5d4-11eb-99b0-a6c473423190.png)



## **Day 5**: if, case, for loop and for generate
  
  1a) Lab on incomplete_if.v --> Simulation
  
  ![image](https://user-images.githubusercontent.com/86380243/123522150-8da20000-d689-11eb-978f-b9150de0edd2.png)
  
  Clearly it can be seen that there is a latch condition when i0 goes low, the y is held either at 0 or 1.
  
  1b) Lab on incomplete_if.v --> Synthesis
  
  ![image](https://user-images.githubusercontent.com/86380243/123522223-04d79400-d68a-11eb-9106-1c95a7ece0af.png)

  The synthesis tool also infers a latch as we expeced from simulating
  
  
  2a) Lab on incomplete_if2.v --> Simulation
  
  ![image](https://user-images.githubusercontent.com/86380243/123522377-e4f4a000-d68a-11eb-90c7-ec426d78b2ad.png)
  
  Clearly it can be seen that there is a latch condition.

  2b) Lab on incomplete_if2.v --> Synthesis
  
  ![image](https://user-images.githubusercontent.com/86380243/123522473-7f54e380-d68b-11eb-8a7c-4e1a33f70a41.png)
  
  The synthesis tool also infers a latch as we expeced from simulating

  3a) Lab on incomp_case.v --> Simulation
  
  ![image](https://user-images.githubusercontent.com/86380243/123525901-17f65e00-d6a2-11eb-84d5-726bcb9daae5.png)
  
  Clearly when sel becomes 10 or 11 the output is being latched to the previous y and hence a latch is inferred.

  3b) Lab on incomp_case.v --> Synthesis
  
  ![image](https://user-images.githubusercontent.com/86380243/123526859-96ee9500-d6a8-11eb-8407-8fcdbd932ecd.png)

  
  4a) Lab on comp_case.v --> Simulation
  
  ![image](https://user-images.githubusercontent.com/86380243/123526957-6a874880-d6a9-11eb-8be5-d2535e4b9a9f.png)
  
  Clearly there is no latch infered.
  
  4b) Lab on incomp_case.v --> Synthesis
  
  ![image](https://user-images.githubusercontent.com/86380243/123527020-f7ca9d00-d6a9-11eb-8347-11ccdae1bfed.png)
  
  Seen from synthesis, there is no latch.
  
  5) Lab on patial_case_assign.v --> Synthesis

  ![image](https://user-images.githubusercontent.com/86380243/123527128-0cf3fb80-d6ab-11eb-8466-a15f8fcbe5d4.png)
  
  
  6a) Lab on bad_case .v --> Simulation
  
  ![image](https://user-images.githubusercontent.com/86380243/123527247-d1a5fc80-d6ab-11eb-8545-de6d95e14620.png)

  Clearly when sel is 11 the outut is latched to some value as the simulator might be confused.
  
  6b) Lab on bad_case.v --> Synthesis  
  
  ![image](https://user-images.githubusercontent.com/86380243/123527283-33666680-d6ac-11eb-9bf0-c5cd80f5dd67.png)
 
  As we can see that there are no latches and we get a 4:1 mux
  
  6c) Lab on bad_case.v --> GLS simulation after write_verilog
  
  ![image](https://user-images.githubusercontent.com/86380243/123527368-d7e8a880-d6ac-11eb-8def-63327cca070d.png)
  
  As we can see it is a 4:1 MUX without any latching and hence a synthesis simulation mismatch
  
  ### for and for generate
  
  7a) Lab on mux_generate.v --> Simulation
  
  ![image](https://user-images.githubusercontent.com/86380243/123528286-29e0fc80-d6b4-11eb-8dce-43a2783b481f.png)

  As we can see its behaving exactly a 4:1 Mux

  7b) Lab on mux_generate.v --> Synthesis  
  
  ![image](https://user-images.githubusercontent.com/86380243/123528438-f81c6580-d6b4-11eb-9f0c-067bfaf669dd.png)
  
  7c) Lab on mux_generate.v --> GLS simulation after write_verilog
  
  ![image](https://user-images.githubusercontent.com/86380243/123528528-e5566080-d6b5-11eb-817d-269826123344.png)
  
  It matches the behaviour of RTL
  
  8a) Lab on demux_case.v --> Simulation
  
  ![image](https://user-images.githubusercontent.com/86380243/123528781-3c5d3500-d6b8-11eb-9d96-fc3aa252c272.png)
   
  8b) Lab on demux_case.v --> Synthesis
  
  ![image](https://user-images.githubusercontent.com/86380243/123528796-7d554980-d6b8-11eb-9a84-7d4a5f2f2dc8.png)
 
  8c) Lab on mux_generate.v --> GLS simulation after write_verilog
  
  ![image](https://user-images.githubusercontent.com/86380243/123528837-fbb1eb80-d6b8-11eb-96b4-aaf8f0fbee43.png)
  
  
  9a) Lab on demux_generate.v --> Simulation
  
  ![image](https://user-images.githubusercontent.com/86380243/123528925-a6c2a500-d6b9-11eb-859d-d1aa5b271d5d.png)


  9b) Lab on demux_generate.v --> Synthesis
  
  ![image](https://user-images.githubusercontent.com/86380243/123528944-e1c4d880-d6b9-11eb-9a81-df5330ca97b5.png)
 
  9c) Lab on mux_generate.v --> GLS simulation after write_verilog
  
  ![image](https://user-images.githubusercontent.com/86380243/123528991-4d0eaa80-d6ba-11eb-8ff5-9e8ef926c8e3.png)
  
  10a) Lab on rca.v --> Simulation
  
  ![image](https://user-images.githubusercontent.com/86380243/123529322-0d958d80-d6bd-11eb-8ea6-36d42ccbba39.png)
  
  10b) Lab on rca.v --> Synthesis
  
  ![image](https://user-images.githubusercontent.com/86380243/123529427-15a1fd00-d6be-11eb-82c1-94e556d2485a.png)

  NOTE: in yosys. first read rca.v and then read fa.v
 
  10c) Lab on rca.v --> GLS simulation after write_verilog
  
  ![image](https://user-images.githubusercontent.com/86380243/123529484-8fd28180-d6be-11eb-9469-6c29441e90f4.png)

  
  
  # Acknowledgements
  
  Kunal Ghosh
  
  Shon Taware
  
  All other members at VSD-IAT



  

  


   



   
 




   










 
     
