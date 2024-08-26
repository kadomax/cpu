
#all programs must start with a NOP for timing purposes.
#all instructions must have an operand even if the instruction does not need it. eg: ADD 0x00
#this is because the operand field in the ir will be filled with this number.
# make sure that there are no trailing spaces at the end of the instruction.
# make sure there is only one space between.
#for branching add the difference between the branch instruction and the instruction to be branched to.


#split the instruction into opcode and operand
#use the dictionary to get bin of opcode
#use format function to get bin of operand
#concatenate the two binary strings
def get_bin_instruction(instruction):
    opcodes_dict = {
        "ADD" : "0000",
        "SUB" : "0001",
        "AND" : "0010",
        "OR" : "0011",
        "XOR" : "0100",
        "B" : "0101",
        "BP" : "0110", 
        "BN" : "0111",
        "BZ" : "1000",
        "LDRIA" : "1001",
        "LDRIB" : "1010",
        "LDRA" : "1011",
        "LDRB" : "1100",
        "STR" : "1101",
        "NOP" : "1110",
        "HLT" : "1111"
    }

    split_instruction = instruction.split()
    opcode_str_string = split_instruction[0]
    operand_str_string = split_instruction[1]

    opcode_bin_string = opcodes_dict[opcode_str_string]
    #convert to 8-bit binary using the format function
    operand_bin_string = format(int(operand_str_string , 16) , "08b")

    bin_instruction = "".join([opcode_bin_string , operand_bin_string])

    return bin_instruction


def main():
    filename = input("enter a filename: ")
    instruction_bin = ""
    with open(filename , "r") as file:
        for line in file:
            instruction_bin = get_bin_instruction(line)
            print(instruction_bin)

main()
    