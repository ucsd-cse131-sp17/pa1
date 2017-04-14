open Compile
open Runner
open Printf
open OUnit2
open MyTests

let is_osx = Conf.make_bool "osx" false "Set this flag to run on osx";;

let t program expected = 
  match program with 
  | Code (name, src) -> name>::test_run src name expected
  | File name        -> name>::test_run_file ("input/" ^ name) name expected
;;

let forty_one = "sub1(42)";;
let def_x = "let x = 5 in let x = 67 in sub1(x)";;
let nested_add = "5 + (10 + 20)";;

let myTestTs = List.map
  (fun (test, ans) -> t test ans) 
  myTestList;;

let suite =
"suite">:::
[
  t (Code ("forty_one" , forty_one )) "41";
  t (Code ("def_x"     , def_x     )) "66";
  t (Code ("nested_add", nested_add)) "35";
  t (File "forty_two.ana") "42";
] 
@ myTestTs
;;

let () =
  run_test_tt_main suite
;;
