# riscV-pipelined-processor
### see my riscV non pipelined processor [click-HERE](https://github.com/CroosJJSE/RISC_V_NON-pipelined-processor)





non-pipelined             |  pipelined
:-------------------------:|:----------------------------------:
![image](https://github.com/CroosJJSE/riscV-pipelined-processor/assets/141708783/a25ae238-8410-4eb8-b69e-eba80acf3241) | ![image](https://github.com/CroosJJSE/riscV-pipelined-processor/assets/141708783/e531fc16-0f0d-47e1-887d-bc5997be6f40)

## What is Pipelining?

Pipelining is a technique used in processor design to execute multiple instructions concurrently by breaking down the execution process into several stages. Each stage of the pipeline handles a specific task of instruction execution, allowing multiple instructions to be processed simultaneously.

## Importance of Pipelining

Pipelining offers several key advantages that contribute to overall performance improvement in processors:

### 1. Increased Throughput

By allowing multiple instructions to be processed simultaneously, pipelining increases the throughput of the processor. This means that more instructions can be executed in a given unit of time, leading to improved performance.

### 2. Reduced Instruction Latency

Pipelining reduces the average time taken to execute an instruction by overlapping the execution of multiple instructions. As a result, the latency of individual instructions is decreased, leading to faster program execution.

### 3. Resource Utilization

Pipelining enables better utilization of hardware resources by keeping them busy throughout the instruction execution process. This helps to maximize the efficiency of the processor and ensures optimal usage of resources.

### 4. Improved Instruction Level Parallelism (ILP)

Pipelining exploits ILP by allowing multiple instructions to progress through different stages of the pipeline simultaneously. This increases the degree of parallelism in instruction execution, resulting in better performance.

## Performance Parameter Improvement

Pipelining enhances various performance parameters of processors, including:

### 1. Instruction Throughput

Pipelining increases the number of instructions completed per unit of time, leading to higher throughput.

### 2. Clock Cycle Time

With pipelining, the effective clock cycle time of the processor is reduced, as instructions are overlapped and executed concurrently.

### 3. Instruction Latency

Pipelining decreases the average instruction latency by allowing instructions to progress through the pipeline simultaneously, reducing the time taken to complete individual instructions.

### 4. Resource Utilization

Pipelining improves the utilization of hardware resources by keeping them occupied more efficiently during instruction execution.








### lets build pipelined processor

non-pipelined             |  pipelined
:-------------------------:|:-------------------------:
 ![image](https://github.com/CroosJJSE/riscV-pipelined-processor/assets/141708783/6f7fe8b3-f27c-4532-b8ea-8ec71dffe8a7) |  ![image](https://github.com/CroosJJSE/riscV-pipelined-processor/assets/141708783/cc8add85-552a-4b3f-93ca-5781e089802f)


# step 1 - seperate stages using registers

## Pipelined Stages
The processor pipeline is divided into the following stages:

1. **Instruction Fetch (IF):**
   - Fetches instructions from memory.
   - Increments the program counter (PC) for the next instruction.
   - Sends the fetched instruction to the ID stage.

2. **Instruction Decode (ID):**
   - Decodes the fetched instruction.
   - Determines the operation to be performed and the operands involved.
   - Sends the decoded instruction to the EX stage.

3. **Execute (EX):**
   - Executes arithmetic, logic, or control operations.
   - Calculates memory addresses for load/store instructions.
   - Sends the result or address to the MEM stage.

4. **Memory Access (MEM):**
   - Accesses memory if required (e.g., load/store operations).
   - Reads data from or writes data to memory.
   - Sends the data or result to the WB stage.

5. **Write Back (WB):**
   - Writes back the result of the operation to the register file.
   - Updates register values based on the instruction executed.

## Separation Using Registers
To separate the stages, registers are used to store the intermediate results and control signals between each stage. Each stage is associated with specific register(s) to hold the relevant data until it is needed by the next stage. This separation ensures that each stage operates independently and concurrently, improving processor performance through pipelining.


Check my [schemetic](https://github.com/CroosJJSE/riscV-pipelined-processor/blob/main/Schematics/stage_seperatedUsingRegisters.pdf).

### check the data indepent instruction are working expected 
### R-type - done
### i-TYPE - done
### Load and store done
# BRANCH IS NOT WORKING
why?
branch comparator in execution stage, but we want BrEq singnal on decode stage to decide the branching,
## temp solution, : bring comparator inside decode stage : done
### JAL JALR are done, but we can see some issue in pc increments, (control hazards),
![image](https://github.com/CroosJJSE/riscV-pipelined-processor/assets/141708783/e0e4ba61-1239-4e85-af50-055271a5dd8e)


## Let's fix it
these are Hazards in Pipelined Processors

Hazards:

1. Structural Hazards: Arise when hardware resources are unable to support concurrent execution of all pipeline stages. For instance, simultaneous access requests to a single resource like memory or a register file.

2. Data Hazards:
    - Read-After-Write (RAW): Occurs when an instruction depends on the result of a previous instruction that has not yet completed.
    - Write-After-Read (WAR): Happens when a later instruction writes to a register before an earlier instruction reads from it.
    - Write-After-Write (WAW): Arises when two instructions write to the same register, with the second write occurring before the first write is complete.

3. Control Hazards: Arise due to changes in the instruction flow caused by conditional branches or jumps. Instructions fetched but not yet executed may need to be flushed if the control flow changes.

Mitigation Strategies:

1. Forwarding (Data Forwarding or Bypassing): Allows data to bypass intermediate pipeline stages and be transferred directly to the stage where it's needed, reducing RAW hazards.

2. Stalling (Pipeline Bubble): Inserting NOP (No Operation) cycles into the pipeline to stall execution until data dependencies are resolved, mitigating RAW hazards.

3. Branch Prediction: Predicting the outcome of conditional branches to speculatively fetch and execute instructions, reducing the impact of control hazards.

4. Instruction Reordering: Reordering instructions to minimize data hazards or utilizing out-of-order execution techniques to execute independent instructions concurrently.

5. Hardware Interlocking: Employing hardware mechanisms like scoreboarding or Tomasulo's algorithm to detect and resolve data hazards dynamically.

6. Compiler Optimizations: Utilizing techniques like loop unrolling, software pipelining, and register allocation to minimize data hazards at the compilation stage.

Conclusion:

Understanding and mitigating hazards in pipelined processors are crucial for optimizing performance and achieving efficient execution of instructions. By employing a combination of hardware and software techniques, the impact of hazards can be minimized, leading to improved throughput and overall system efficiency.

