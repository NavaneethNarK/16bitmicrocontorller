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
        c.removeWhiteSpace()
        print("program compiled")

class assembler:
    def __init__(self,str):
        self.str = str
    
    def removeWhiteSpace(self):
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

        print(code_list)
        print(jmp_dic)

    def compile(self):
        pass
if __name__ == "__main__":
    text_editor = TextEditor()