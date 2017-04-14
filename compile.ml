open Printf

type reg =
  | EAX
  | ESP

type arg =
  | Const of int
  | Reg of reg
  | RegOffset of int * reg

type instruction =
  | IMov of arg * arg
  | IAdd of arg * arg
  | ISub of arg * arg
  | IMul of arg * arg
  | IRet

type prim1 =
  | Add1
  | Sub1

type prim2 =
  | Plus
  | Minus
  | Times

type expr =
  | ELet of (string * expr) list * expr
  | EPrim1 of prim1 * expr
  | EPrim2 of prim2 * expr * expr
  | ENumber of int
  | EId of string

let r_to_asm (r : reg) : string =
  match r with
    | EAX -> "eax"
    | ESP -> failwith "ESP not yet implemented"

let arg_to_asm (a : arg) : string =
  match a with
    | Const(n) -> sprintf "%d" n
    | Reg(r) -> r_to_asm r
    | RegOffset(n, r) -> failwith "RegOffset not yet implemented"

let i_to_asm (i : instruction) : string =
  match i with
    | IMov(dest, value) ->
      sprintf "  mov %s, %s" (arg_to_asm dest) (arg_to_asm value)
    | IAdd(dest, to_add) ->
      failwith "You need to do this one (add)"
    | ISub(dest, to_sub) ->
      failwith "You need to do this one (sub)"
    | IMul(dest, to_mul) ->
      failwith "You need to do this one (mul)"
    | IRet ->
      "  ret"

let to_asm (is : instruction list) : string =
  List.fold_left (fun s i -> sprintf "%s\n%s" s (i_to_asm i)) "" is

let rec find ls x =
  match ls with
    | [] -> None
    | (y,v)::rest ->
      if y = x then Some(v) else find rest x

let rec compile_expr (e : expr) (si : int) (env : (string * int) list) : instruction list =
  match e with
    | EPrim1(op, arge) ->
      failwith "Compile Prim1 not yet implemented"
    | EPrim2(op, el, er) ->
      failwith "Compile Prim2 not yet implemented"
    | EId(x) -> 
      failwith "Compile Id not yet implemented"
    | ENumber(n) -> [IMov(Reg(EAX), Const(n))]
    | ELet(bs, body) ->
      failwith "Compile ELet not yet implemented"

let compile_to_string prog =
  let prelude =
    "section .text
global our_code_starts_here
our_code_starts_here:" in
  let compiled = (compile_expr prog 1 []) in
  let as_assembly_string = (to_asm (compiled @ [IRet])) in
  sprintf "%s%s\n" prelude as_assembly_string

