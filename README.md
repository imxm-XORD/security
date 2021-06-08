# Renetrancy
In my opinion its a type of control flow attack. The program execution is halted in the middle and somehow re-initiated. The halt occurs because some low level function calls some other function (mostly external functions)
## Mitigations
- pay attention to external calls
- checks effects pattern
- any ether transfer should be done at the end
- check if ethers are being transfered to contract or not. 
