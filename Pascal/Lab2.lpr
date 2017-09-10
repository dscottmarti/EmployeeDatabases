(*
Program Name: Lab2
Student Names: Duncan Scott Martinson & John Payton
Semester: Spring 2017
Class: COSC 30403
Instructor: Dr. James Comer
Due Date: 2/21/2017

Program Overview:
   This pascal program uses a text file to input data into a linked list of
   Employees and execute commands in order to manipulate the list. After every
   command, the program writes information about the execution to a separate text file.
   After all the data from the file has been read, the program terminates.

Input:
   The program requires formatted data in a text file entitled "Lab2Data.txt"

Output:
   The program outputs a data file entitled "Lab2Ans.txt" containing information
   about the program's execution.

Program Limitations:
   1) The program does not allow for real time user interaction, and the output file
   is overwritten after every execution.


Significant Program Variables:
   input - the identifier for the input file
   output - the identifier for the output file
   cmd - a string that stores the first three characters read from a line of input. This is used to
       determine the appropriate subroutine to execute.
   head- an Employee node that serves as the list head. Used to reference the linked list.
   current- an Employee Node pointer used in almost every procedure. Is used to traverse the list and
           analyze data, manipulating it if need be.


*)
program Lab2;
Uses sysutils;
//Defining the data types used to make the linked list
type
  Employee = Record
    id : Integer;
    name : String[12];
    dept, title : String[16];
    pay : Real;
  end;
  Pointer = ^Node;
  Node = Record
    data : Employee;
    next : Pointer;
  end;
//Global variables used to store important values
var
  head : Node;
  input, output : text;
  cmd : String[3];
  temp : Employee;
  targetID : Integer;
  tempName: String[12];
  tempDept : String[16];
  tempTitle : String[16];
  tempPay: Real;
//This procedure initializes the linked list
procedure initList;
begin
  head.data.id:=0;
  head.next:=nil;
end;

(*
The insert procedure starts with a pointer to the head node and checks to see if there is an employee to the
    right. If there isn't, it inserts the new employee to the right and stops the loop. If there is,
     it compares the new employee to the one to the right. If the new id is smaller than the id of the node
     to the right, it inserts the new employee to the right of the pointer. If it is larger, it advances the pointer.
    The reasoning behind looking one down the list instead of at the current node was to be able to effectively remove
    without having to waste memory on a doubly linked list.
*)
procedure insert(newTemp : Employee);
var
  current : Pointer = @head;
  newNode : Pointer;
begin
     new(newNode);
     newNode^.data := newTemp;
     newNode^.next :=nil;
    while (true) do begin
       if (current^.next = nil) then begin
         current^.next := newNode;
         writeln(output, 'Employee #', format('%.8d', [newTemp.id]), ' inserted.');
         break;
       end
       else if(newNode^.data.id<current^.next^.data.id) then begin
         newNode^.next:=current^.next;
         current^.next := newNode;
         writeln(output, 'Employee #', format('%.8d', [newTemp.id]), ' inserted.');
         break;
         end

       else
           current := current^.next;
    end;
end;
//This procedure finds a specific employee in the data structure and prints out all of its data.
procedure printEmployee(x : Employee);
begin
    write(output, format('%.8d', [x.id]), ' ');
    write(output, x.name,' ');
    write(output, x.dept, ' ');
    write(output, x.title, ' ');
    write(output, format('%2.2f',[x.pay]), ' ');
    writeln(output);
end;
procedure delete(num: integer);
  var current : Pointer = @head;
      newNode : Pointer;
      found : Boolean = false;
  begin
       while(true) do begin
          if(current^.next = nil) then begin
            break;
          end
          else if(current^.next^.data.id = num) then begin
            found := true;
            newNode:=current^.next;
            current^.next:= current^.next^.next;
            dispose(newNode);
            writeln(output,'Employee #',format('%.8d', [num]),' deleted.');
            break;
          end
          else
              current:=current^.next;
       end;
       if(not found) then
            writeln(output, 'DE ERROR: Employee ', format('%.8d', [num]),' not found.');
    end;

//This procedure goes through the data structure and prints out all the information of each node
procedure printAll;
var
  current : Pointer = @head;
begin
    current := current^.next;
    writeln(output, 'BEGIN PRINT ALL:');
    while (true) do begin
       if(current = nil) then
         break;
       printEmployee(current^.data);
       current:=current^.next;
  end;
    writeln(output, 'END PRINT ALL.');
end;
(*This procedure finds a specific employee in the list
 and changes its name to the given string*)
procedure updateName(num : integer; newName : String);
var
  current : Pointer = @head;
  found: Boolean = false;
   begin
       while(true) do begin
          if(current^.next^.data.id = num) then begin
            current^.next^.data.name:=newName;
            writeln(output,'Employee #',format('%.8d', [num]),' name updated to ', Trim(newName), '.');
            found:=true;
            break;
          end
          else if(current^.next = nil) then begin
            break;
          end
          else
              current:=current^.next;
       end;
       if(not found) then
              writeln(output, 'UN ERROR: Employee ', format('%.8d', [num]),' not found.');
    end;
(*This procedure goes through the list and updates the department
of a specific employee to the given string*)
procedure updateDept(num : Integer; newDept : String);
var
  current : Pointer = @head;
  found: Boolean = false;
   begin
       while(true) do begin
          if(current^.next^.data.id = num) then begin
            current^.next^.data.dept:=newDept;
            writeln(output,'Employee #',format('%.8d', [num]),' department updated to ', Trim(newDept), '.');
            found:=true;
            break;
          end
          else if(current^.next = nil) then begin
            break;
          end
          else
              current:=current^.next;
       end;
       if(not found) then
            writeln(output, 'UD ERROR: Employee ', format('%.8d', [num]),' not found.');
    end;
(*This procedure goes through the list and updates the
title of a specific employee to the given string*)
procedure updateTitle(num : integer; newTitle : String);
var
  current : Pointer = @head;
  found: Boolean = false;
   begin
       while(true) do begin
          if(current^.next^.data.id = num) then begin
            current^.next^.data.title:=newTitle;
            writeln(output,'Employee #',format('%.8d', [num]),' title updated to ', Trim(newTitle), '.');
            found:=true;
            break;
          end
          else if(current^.next = nil) then begin
            break;
          end
          else
              current:=current^.next;
    end;
        if(not found) then
            writeln(output, 'UT ERROR: Employee ', format('%.8d', [num]),' not found.');
       end;
(*This procedure finds a specific employee by their id and prints
out all of their information*)
procedure printID(num: integer);
var
  current : Pointer = @head;
  found: Boolean = false;
   begin
       while(true) do begin
          if(current = nil) then
            break
          else if(current^.data.id = num) then begin
            write(output, 'Print Employee: ');
            printEmployee(current^.data);
            found:=true;
            break;
          end
          else
              current:=current^.next;
       end;
        if(not found) then
            writeln(output, 'PI ERROR: Employee ', format('%.8d', [num]),' not found.');
    end;
(*This procedure goes through the list and updates
a specific employee's payrate to the given value*)
procedure updatePay(num : integer; newPay : Real);
var
  current : Pointer = @head;
  found: Boolean = false;
   begin
       while(true) do begin
          if(current^.data.id = num) then begin
            current^.data.pay:=newPay;
            writeln(output,'Employee #',format('%.8d', [num]),' payrate updated to ', format('%2.2f',[newPay]), '.');
            found:=true;
            break;
          end
          else if(current^.next = nil) then
            break
          else
              current:=current^.next;
       end;
       if(not found) then
            writeln(output, 'UR ERROR: Employee ', format('%.8d', [num]),' not found.');
    end;
(*This procedure goes through the list and prints out
all the information of employees in the given department*)
procedure printDept(target : String);
var
  current : Pointer = @head;
  found: Boolean = false;
   begin
       writeln(output, 'BEGIN PRINT DEPARTMENT: ', Trim(target));
       while(true) do begin
          if(current = nil) then
               break
          else if(CompareText(Trim(current^.data.dept), Trim(target)) = 0) then begin
            printEmployee(current^.data);
            found:=true;
            current:=current^.next;
          end
          else begin
              current:=current^.next;
          end;
       end;
       if(not found) then
            writeln(output, 'PD ERROR: ', Trim(target), ' department not found.');
       writeln(output, 'END PRINT DEPARTMENT: ', Trim(target));
    end;
(*This is the program body*)
begin
  //Initialize the list
  initList;
  //Set up the I/O
  assign(input, 'Lab2Data.txt');
  assign(output, 'Lab2Ans.txt');
  reset(input);
  rewrite(output);

  writeln(output, 'BEGIN PROGRAM');
  //Loop until the end of the file is reached
  while not EOF(input) do
  begin
     //read in the command
     read(input, cmd);
     //execute the appopriate procedure
     Case cmd of
       'IN ' : begin
                read(input, temp.id);
                read(input, temp.name);
                read(input, temp.dept);
                read(input, temp.title);
                read(input, temp.pay);
                readln(input);
                insert(temp);
            end;
       'PA ' : begin
         printAll;
         readln(input);
         end;
       'DE ' : begin
                read(input, targetID);
                delete(targetID);
                readln(input);
            end;
       'UN ' : begin
          read(input, targetID);
          read(input, tempName);
          read(input, tempDept);
          read(input, tempName);
          updateName(targetID, tempName);
          readln(input);
            end;
       'UD ': begin
          read(input, targetID);
          read(input, tempName);
          read(input, tempDept);
          read(input, tempDept);
          updateDept(targetID, tempDept);
          readln(input);
          end;
       'UT ': begin
          read(input, targetID);
          read(input, tempName);
          read(input, tempDept);
          read(input,tempTitle);
          updateTitle(targetID, tempTitle);
          readln(input);
          end;
       'PI ': begin
          read(input,targetID);
          printID(targetID);
          readln(input);
          end;
       'PD ': begin
          read(input, tempDept);
          printDept(tempDept);
          readln(input);
          end;
       'UR ': begin
          read(input, targetID);
          read(input, tempName);
          read(input,tempDept);
          read(input,tempPay);
          updatePay(targetID, tempPay);
          readln(input);
          end;
       end;

  end;
  writeln(output, 'END PROGRAM.');
  //Clean up the I/O
  close(input);
  close(output);
end.

