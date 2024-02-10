import tkinter as tk
from tkinter import filedialog

class TextEditor:
    def __init__(self):
        self.window = tk.Tk()
        self.window.title("asm Text Editor")

        self.text_area = tk.Text(self.window, wrap=tk.WORD)
        self.text_area.pack(expand=tk.YES, fill=tk.BOTH)

        self.create_menu()

        self.window.mainloop()

    def create_menu(self):
        menu = tk.Menu(self.window)
        self.window.config(menu=menu)

        file_menu = tk.Menu(menu)
        menu.add_cascade(label="File", menu=file_menu)
        file_menu.add_command(label="New", command=self.new_file)
        file_menu.add_command(label="Open", command=self.open_file)
        file_menu.add_command(label="Save", command=self.save_file)
        file_menu.add_separator()
        file_menu.add_command(label="Exit", command=self.window.quit)

       
        compile_menu = tk.Menu(menu)
        menu.add_cascade(label="Compile", menu = compile_menu)
        compile_menu.add_command(label="Compile", command=self.compile_file)

    def new_file(self):
        self.text_area.delete(1.0, tk.END)

    def open_file(self):
        file = filedialog.askopenfilename(defaultextension=".asm", filetypes=[("Text Files", "*.asm"), ("All Files", "*.*")])
        if file:
            self.window.title(f"asm Text Editor - {file}")
            self.text_area.delete(1.0, tk.END)
            with open(file, "r") as file_handler:
                self.text_area.insert(tk.INSERT, file_handler.read())

    def save_file(self):
        file = filedialog.asksaveasfilename(defaultextension=".asm", filetypes=[("Text Files", "*.asm"), ("All Files", "*.*")])
        if file:
            with open(file, "w") as file_handler:
                file_handler.write(self.text_area.get(1.0, tk.END))
            self.window.title(f"asm Text Editor - {file}")

    def compile_file(self):
        c = assembler(self.text_area.get(1.0, tk.END))
        bin_code_string = c.assemble()
        f = open("bincode.txt",'w')
        f.write(bin_code_string)
        f.close()
        print("program compiled")
    

dest_opcode = {"0":"000",
                  "M":"001",
                  "D":"010",
                  "MD":"011",
                  "DM":"011",
                  "A":"100",
                  "AM":"101",
                  "MA":"101",
                  "AD":"110",
                  "DA":"110",
                  "ADM":"111",
                  "AMD":"111",
                  "DAM":"111",
                  "DMA":"111",
                  "MAD":"111",
                  "MDA":"111"}
    
jmp_opcode = {"NULL":"000",
                   "JGT":"001",
                   "JEQ":"010",
                   "JGE":"011",
                   "JLT":"100",
                   "JNE":"101",
                   "JLE":"110",
                   "JMP":"111"}
    
alu_opcode = {"0":"101010",
                  "1":"111111",
                  "-1":"111010",
                  "D":"001100",
                  "Y":"110000",
                  "!D":"001101",
                  "!Y":"110001",
                  "-D":"001111",
                  "-Y":"110011",
                  "D+1":"011111",
                  "Y+1":"110111",
                  "D-1":"001110",
                  "Y-1":"110010",
                  "D+Y":"000010",
                  "D-Y":"010011",
                  "Y-D":"000111",
                  "D&Y":"000000",
                  "D|Y":"010101"}
class assembler:
    def __init__(self,str):
        self.str = str
    
    def assemble(self):
        #remove comments
        temp_str = ''
        found_next_line = 1
        for i in self.str:
            if i == '#':
                found_next_line = 0
            if i == '\n':
                found_next_line = 1
            if found_next_line == 0:
                continue
            temp_str = temp_str+i
        self.str = temp_str

        #remove double next line
        temp_str = ''
        found_next_line = 1
        for i in self.str:
            if (found_next_line == 1)and(i == '\n'):
               continue
            if i == '\n':
                found_next_line = 1
            else:
                found_next_line = 0
            temp_str = temp_str+i
        self.str = temp_str

        #remove spaces
        temp_str = ''
        for i in self.str:
            if i != ' ':
                temp_str = temp_str + i
        self.str = temp_str
        
        #make the code string to a list for string line by line
        code_list = self.str.split('\n')
        code_list = [x for x in code_list if x != '']

        #save jump points
        jmp_dic ={}
        rom_address = 0
        for i in range(len(code_list)):
            if code_list[i][0] == '(':
                jmp_dic[code_list[i][1:-1]]=rom_address
                continue
            rom_address+=1
        code_list = [x for x in code_list if x[0]!='(']
        
        #replace location label with location address
        for i in range(len(code_list)):
            if code_list[i][0] == '@':
                if code_list[i][1:] in jmp_dic:
                    code_list[i] = '@'+str(jmp_dic[code_list[i][1:]])

        #Ideal asembly code conversion
        for i in range(len(code_list)):
            if code_list[i][0] != '@':
                #C instruction
                if '=' not in code_list[i]:
                    code_list[i] = "0="+code_list[i]
                if ';' not in code_list[i]:
                    code_list[i]=code_list[i]+';NULL'
        bin_code_str = compile(code_list)
        return bin_code_str
        

    
    
def hex2bin(strng):
    addr_int  = int('0x'+strng,16)
    addr_bin = bin(addr_int)
    addr_bin = addr_bin[2:]
    addr_bin = (15-len(addr_bin))*'0'+addr_bin
    return addr_bin        

def compile(code_list):
    global jmp_opcode, dest_opcode, alu_opcode
    bin_code = []
    for i in range(len(code_list)):
        if code_list[i][0]=='@':
            bin_code.append('0'+hex2bin(code_list[i][1:]))
        else:
            temp_code = code_list[i].split('=')
            dst_code = temp_code[0]
            temp_code = temp_code[1].split(';')
            alu_code = temp_code[0]
            jmp_code = temp_code[1]
            temp_alu = ''
            a = '0'
            for j in alu_code:
                if j == 'A': 
                    a = '0'
                    temp_alu = temp_alu + 'Y'
                    continue
                elif j == 'M':
                    a = '1'
                    temp_alu = temp_alu + 'Y'
                    continue
                temp_alu = temp_alu + j
            alu_code = temp_alu
            bin_code.append('111'+a+alu_opcode[alu_code]+dest_opcode[dst_code]+jmp_opcode[jmp_code])
    bin_code_string = ''
    for i in bin_code:
        bin_code_string = bin_code_string + i + '\n'
    return bin_code_string          

if __name__ == "__main__":
    text_editor = TextEditor()