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
