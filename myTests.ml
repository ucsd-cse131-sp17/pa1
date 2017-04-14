(*
 *  Fill in `myTestList` with your own tests. There are two ways to add a test:
 *
 *  (1) By adding the code of the program as a string. In this case add an entry
 *      of this form in `myTestList`:
 *      
 *      (Code (<name>, <program>), <result>)
 *
 *      For example:
 *    
 *      (Code ("Additions", "5 + (10 + 20)"), "35")
 *
 *  (2) By adding a test inside the 'input/' folder and adding an entry for it
 *      in `myTestList`. The entry in this case should be:
 *
 *      (File <name>, <result>)
 *
 *      Where name is the name of the file inside 'input/' with the extension
 *      ".ana". For example:
 *        
 *      (File "mytest.ana", "6");
 *
 *      Use a semicolon to separate your individual tests.
 *)

type test_descr = 
  | Code of string * string 
  | File of string

let myTestList = 
 [ (* Fill in your tests here: *)
 ]
;;

